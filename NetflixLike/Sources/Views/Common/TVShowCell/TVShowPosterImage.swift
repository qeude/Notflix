//
//  TVShowPosterImage.swift
//  NetflixLike
//
//  Created by Quentin Eude on 19/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct TVShowPosterImage: View {
    private let tvShow: TVShow

    init(for tvShow: TVShow) {
        self.tvShow = tvShow
    }

    var body: some View {
        Group {
            if tvShow.posterUrl != nil {
                AsyncImage(url: tvShow.posterUrl!,
                           configuration: {$0.resizable()},
                           defaultView: {
                            AnyView(
                                Text(self.tvShow.title)
                                    .fontWeight(.bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            )
                })
            } else {
                Text(self.tvShow.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
            }
        }
        .frame(width: 150, height: 245)
        .background(Color.darkGray)
        .cornerRadius(8.0)
    }
}

struct TVShowPosterImage_Previews: PreviewProvider {
    static var previews: some View {
        TVShowPosterImage(for: TVShow(id: 1402,
                                         title: "The Walking Dead",
                                         overview: """
                                          Sheriff's deputy Rick Grimes awakens from a
                                          coma to find a post-apocalyptic world dominated
                                          by flesh-eating zombies. He sets out to find his
                                          family and encounters many other survivors along
                                          the way.
                                          """,
                                         popularity: 124.898,
                                         voteAverage: 7.3,
                                         voteCount: 4607,
                                         genreIds: [10759, 18, 10765],
                                         genres: nil,
                                         posterPath: "/5l10EjdgPxu8Gbl5Ww6SWkVQH6T.jpg",
                                         backdropPath: "/wXXaPMgrv96NkH8KD1TMdS2d7iq.jpg",
                                         firstAirDate: "2010-10-31", seasons: [
                                            TVSeason(
                                                id: 1,
                                                name: "saison 1",
                                                overview: "overview",
                                                seasonNumber: 1,
                                                posterPath: "/5l10EjdgPxu8Gbl5Ww6SWkVQH6T.jpg"
                                            )]
        ))
    }
}
