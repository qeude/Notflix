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
        self.sourceId = tvShow.id
        self.title = tvShow.title
        self.posterPath = tvShow.posterPath
        self.popularity = tvShow.popularity
    }

    init(movie: Movie) {
        self.type = .movie
        self.id = "\(movie.id)_\(self.type)"
        self.sourceId = movie.id
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.popularity = movie.popularity
    }

    let id: String
    let sourceId: Int
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

    @Published var searchText = ""
    @Published var items = [[SearchItemViewModel]]()
    @Published var state: State = .initial

    private var disposables = Set<AnyCancellable>()

    init() {
        $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .sink { searchText in
                if !searchText.isEmpty {
                    self.performSearch(for: searchText)
                } else {
                    self.items = []
                }
        }.store(in: &disposables)
    }

    func performSearch(for text: String) {
        self.state = .loading
        self.items = []
        var movies = [SearchItemViewModel]()
        var tvShows = [SearchItemViewModel]()
        APIClient().send(APIEndpoints.searchMovies(for: text)).mapError { error -> Error in
            self.state = .error
            self.items = []
            return error
        }
        .flatMap { response -> AnyPublisher<APIResponseList<TVShow>, Error> in
            movies = response.results.map { SearchItemViewModel(movie: $0)}
            return APIClient().send(APIEndpoints.searchTVShows(for: text))
        }
        .mapError { error -> Error in
            self.state = .error
            self.items = []
            return error
        }
        .map { response -> [SearchItemViewModel] in
            tvShows = response.results.map { SearchItemViewModel(tvShow: $0)}
            let concatItems = tvShows + movies
            if concatItems.isEmpty {
                self.state = .data
                self.items = []
            }
            return concatItems.sorted { $0.popularity > $1.popularity }
        }
        .flatMap { $0.publisher.setFailureType(to: Error.self) }
        .collect(3)
        .sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.state = .error
                self.items = []
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.state = .data
            self.items += Array(arrayLiteral: response)
        })
            .store(in: &disposables)
    }
}
