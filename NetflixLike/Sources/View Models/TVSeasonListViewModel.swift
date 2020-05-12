//
//  SeasonListViewModel.swift
//  NetflixLike
//
//  Created by Quentin Eude on 11/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine

class TVSeasonListViewModel: ObservableObject {
    @Published var episodes = [Episode]()

    private var disposables = Set<AnyCancellable>()
    private(set) var isLoading = false
    private static let episodeProcessingQueue = DispatchQueue(label: "episode-processing")

    init(tvShowId: Int, tvSeasonNumber: Int) {
        load(tvShowId: tvShowId, tvSeasonNumber: tvSeasonNumber)
    }

    func load(tvShowId: Int, tvSeasonNumber: Int) {
        isLoading = true
        APIClient().send(APIEndpoints.tvSeason(tvShowId: tvShowId, tvSeasonNumber: tvSeasonNumber))
            .sink(receiveCompletion: { (completion) in
                switch completion {
                case .failure:
                    self.isLoading = false
                    self.episodes = []
                case .finished:
                    break
                }
            }, receiveValue: { (response) in
                self.isLoading = false
                self.episodes = response.episodes
            })
            .store(in: &disposables)
    }
}
