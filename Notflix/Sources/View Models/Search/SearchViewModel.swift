//
//  SearchViewModel.swift
//  Notflix
//
//  Created by Quentin Eude on 16/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine
import CocoaLumberjack

struct SearchItemViewModel {
    enum SearchItemType {
        case tvShow
        case movie
    }

    init(tvShow: TVShow) {
        self.type = .tvShow
        self.id = "\(tvShow.id)_\(self.type)"
        self.title = tvShow.title
        self.posterPath = tvShow.posterPath
        self.popularity = tvShow.popularity
    }

    init(movie: Movie) {
        self.type = .movie
        self.id = "\(movie.id)_\(self.type)"
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.popularity = movie.popularity
    }

    let id: String
    let type: SearchItemType
    let title: String
    let posterPath: String?
    let popularity: Double

    var posterUrl: URL? {
        guard let posterPath = posterPath else {
            return nil
        }
        let url = URL(string: "\(APIClient.baseImageStringUrl)\(posterPath)")
        return url
    }
}

class SearchViewModel: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var searchText = "" {
        didSet {
            if !searchText.isEmpty {
                //TODO: Add delay to debounce api call
                self.performSearch(for: searchText)
            } else {
                self.items = []
            }
        }
    }
    @Published var items = [SearchItemViewModel]()
    @Published var state: State = .initial

    private var disposables = Set<AnyCancellable>()

    func performSearch(for text: String) {
        self.state = .loading
        self.items = []
        APIClient().send(APIEndpoints.searchMovies(for: text)).flatMap { response -> AnyPublisher<APIResponseList<TVShow>, Error> in
            self.items = response.results.map { SearchItemViewModel(movie: $0)}
            return APIClient().send(APIEndpoints.searchTVShows(for: text))
        }.sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.state = .error
                self.items = []
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.state = .data
            self.items.append(contentsOf: response.results.map { SearchItemViewModel(tvShow: $0)})
        })
        .store(in: &disposables)
    }
}
