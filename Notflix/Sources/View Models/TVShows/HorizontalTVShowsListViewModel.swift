//
//  TVShowsViewModel.swift
//  Notflix
//
//  Created by Quentin Eude on 03/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine
import CocoaLumberjack

class HorizontalTVShowsListViewModel: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var tvShows = [TVShow]()
    @Published var state: State = .initial

    private var disposables = Set<AnyCancellable>()

    init(fetcher: APIRequest<APIResponseList<TVShow>>) {
        self.fetchTVShows(fetcher: fetcher)
    }

    private func fetchTVShows(fetcher: APIRequest<APIResponseList<TVShow>>) {
        self.state = .loading
        APIClient().send(fetcher).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.state = .error
                self.tvShows = []
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.state = .data
            self.tvShows = response.results
        })
        .store(in: &disposables)
    }
}
