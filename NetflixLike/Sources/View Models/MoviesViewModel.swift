//
//  MoviesViewModel.swift
//  NetflixLike
//
//  Created by Quentin Eude on 14/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine
import CocoaLumberjack

class MoviesViewModel: ObservableObject {
    @Published var movies = [Movie]()

    private var disposables = Set<AnyCancellable>()

    init(fetcher: APIRequest<APIResponseList<Movie>>) {
        //FIXME: Should handle error here
        APIClient().send(fetcher).sink(receiveCompletion: { (completion) in
            switch completion {
            case .failure:
                self.movies = []
            case .finished:
                break
            }
        }, receiveValue: { (response) in
            self.movies = response.results
        })
        .store(in: &disposables)
    }
}
