//
//  MoviePosterImage.swift
//  NetflixLike
//
//  Created by Quentin Eude on 19/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct MoviePosterImage: View {
   private let movie: Movie

    init(for movie: Movie) {
        self.movie = movie
    }

    var body: some View {
        AsyncImage(url: movie.posterUrl!,
                   configuration: {$0.resizable()},
                   defaultView: {
                    AnyView(
                        Text(self.movie.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                    )
        }).frame(width: 150, height: 245)
            .background(Color.darkGray)
            .cornerRadius(8.0)
    }
}

struct MoviePosterImage_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterImage(for: Movie(id: 330457,
                                      title: "Frozen II",
                                      overview: """
                Elsa, Anna, Kristoff and Olaf head far into
                the forest to learn the truth about an ancient
                mystery of their kingdom.
        """,
                                      popularity: 190.236,
                                      voteAverage: 7.1,
                                      video: false,
                                      adult: false,
                                      voteCount: 2860,
                                      genreIds: [6125, 2], genres: nil,
                                      posterPath: "/pjeMs3yqRmFL3giJy4PMXWZTTPa.jpg",
                                      backdropPath: "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg",
                                      releaseDate: "2019-11-20"))
    }
}
