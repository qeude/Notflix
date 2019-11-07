//
//  MoviesView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 07/11/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var movieListViewModel = MovieListViewModel()

    var body: some View {
        HorizontalListView(self.movieListViewModel.popularMovies)
    }
    private func getNextPageIfNecessary(encounteredIndex: Int) {
        guard encounteredIndex == self.movieListViewModel.popularMovies.count - 10 else { return }
        self.movieListViewModel.nextPage()
    }
}

struct ListRowView: View {
    let movie: Movie

    var body: some View {
        VStack (alignment: .leading) {
            PosterImageView(imageUrl: movie.posterPath!)
            Text(movie.title).bold()
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
