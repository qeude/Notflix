//
//  HomeMoviesViewModel.swift
//  Notflix
//
//  Created by Quentin Eude on 15/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine
import CocoaLumberjack

class HomeMoviesViewModel: ObservableObject {
    enum State {
        case initial
        case loading
        case error
        case data
    }

    @Published var genres = [Genre]()
    @Published var state: State = .initial

    private var disposables = Set<AnyCancellable>()

    init() {
        self.fetchGenres()
    }

    private func fetchGenres() {
        self.state = .loading
        APIClient().send(APIEndpoints.movieGenres).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.state = .error
                self.genres = []
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.state = .data
            self.genres = Array(response.genres.shuffled().prefix(5))
        })
        .store(in: &disposables)
    }
}
