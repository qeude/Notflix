//
//  TVShowDetailsViewModel.swift
//  Notflix
//
//  Created by Quentin Eude on 20/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine

class TVShowDetailsViewModel: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var tvShow: TVShow?
    @Published var state: State = .initial

    private var disposables = Set<AnyCancellable>()

    init(tvShowId: Int) {
        fetchTvShowDetails(tvShowId: tvShowId)
    }

    private func fetchTvShowDetails(tvShowId: Int) {
        self.state = .loading
        APIClient().send(APIEndpoints.tvShow(tvShowId: tvShowId)).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.tvShow = nil
                self.state = .error
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.tvShow = response
            self.state = .data
        })
        .store(in: &disposables)
    }

    private func fetchEpisodes(tvShowId: Int, tvSeasonNumber: Int) -> AnyPublisher<APIResponseTVSeason, Error> {
        return APIClient().send(APIEndpoints.tvSeason(tvShowId: tvShowId, tvSeasonNumber: tvSeasonNumber))
    }
}
