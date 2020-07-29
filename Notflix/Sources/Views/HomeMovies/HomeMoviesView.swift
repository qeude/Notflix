//
//  MoviesView.swift
//  Notflix
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct HomeMoviesView: View {
    @ObservedObject private var homeMovieViewModel: HomeMoviesViewModel

    init() {
        self.homeMovieViewModel = HomeMoviesViewModel()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HorizontalMoviesListView(horizontalMoviesListViewModel: HorizontalMoviesListViewModel(fetcher: APIEndpoints.popularMovies),
                                     listName: L10n.Movies.Popular.title)
            HorizontalMoviesListView(horizontalMoviesListViewModel: HorizontalMoviesListViewModel(fetcher: APIEndpoints.topRatedMovies),
                                     listName: L10n.Movies.Toprated.title)
            ForEach(homeMovieViewModel.genres, id: \.id) { genre in
                HorizontalMoviesListView(horizontalMoviesListViewModel:
                    HorizontalMoviesListViewModel(fetcher: APIEndpoints.moviesForGenre(genreId: genre.id)),
                                         listName: L10n.Movies.With.Genre.title(genre.name))
            }
        }
    }
}

struct HomeMoviesView_Previews: PreviewProvider {
    static var previews: some View {
       ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            HomeMoviesView()
        }
    }
}
