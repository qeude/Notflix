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
    @Published var page : Int = 1
    init() {
        APIService().fetchPopuplarMovies(page:  1) { result in
            self.popularMovies = result.data
        }
    }
    
    func nextPage() {
        self.page += 1
        APIService().fetchPopuplarMovies(page: page) { result in
            self.popularMovies.append(contentsOf: result.data)
        }
    }
    
    let didChange = PassthroughSubject<MovieListViewModel, Never>()
}
