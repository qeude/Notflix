//
//  TVShowsViewModel.swift
//  NetflixLike
//
//  Created by Quentin Eude on 03/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine
import CocoaLumberjack

class TVShowsViewModel: ObservableObject {
    @Published var tvShows = [TVShow]()

    private var disposables = Set<AnyCancellable>()

    init(fetcher: APIRequest<APIResponseList<TVShow>>) {
        // FIXME: Should handle error here
        APIClient().send(fetcher).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.tvShows = []
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.tvShows = response.results
        })
        .store(in: &disposables)
    }
}
