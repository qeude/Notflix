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

class MovieListViewModel: ObservableObject {
    
    @Published var popularMovies: [Movie] = [Movie]()
    @Published var page: Int = 1
    @Published var isLoading: Bool = false

    init() {
        self.isLoading = true
        _ = APIService().fetchPopularMovies(page: 1).done { result in
            self.popularMovies = result.data
            self.isLoading = false
        }
    }
    
    func nextPage() {
        self.isLoading = true
        self.page += 1
        _ = APIService().fetchPopularMovies(page: page).done { result in
            self.popularMovies.append(contentsOf: result.data)
            self.isLoading = false
        }
    }
    
    let didChange = PassthroughSubject<MovieListViewModel, Never>()
}
