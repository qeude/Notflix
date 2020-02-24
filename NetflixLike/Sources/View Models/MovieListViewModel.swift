//
//  MovieListViewModel.swift
//  NetflixLike
//
//  Created by Quentin Eude on 08/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CocoaLumberjack

class MovieListViewModel: ObservableObject {

    var cancellable: AnyCancellable?

    @Published var popularMovies: [Movie] = [Movie]()
    @Published var page: Int = 1
    @Published var isLoading: Bool = false

    init() {
        self.isLoading = true
        //FIXME: Fix this to be handled with Combine
        cancellable = APIClient().send(GetPopularMovies()).sink(receiveCompletion: {  error in
            DDLogError("error while fetching popular movies : \(error)")
        }, receiveValue: { movies in
            movies.results.forEach { movie in
                DDLogDebug("Movie : \(movie.title)")
            }//            self.popularMovies = movies
//            movies.forEach { movie in
//                DDLogDebug("Movie : \(movie.title)")
//            }
        })
    }

    func nextPage() {
        self.isLoading = true
        self.page += 1
//        _ = APIService().fetchPopularMovies(page: page).done { result in
//            self.popularMovies.append(contentsOf: result.data)
//            self.isLoading = false
//        }
    }

    let didChange = PassthroughSubject<MovieListViewModel, Never>()
}
