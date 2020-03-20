//
//  TVShowCell.swift
//  NetflixLike
//
//  Created by Quentin Eude on 14/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct TVShowCell: View {
    var tvShow: TVShow

    init(for tvShow: TVShow) {
        self.tvShow = tvShow
    }

    var body: some View {
        NavigationLink(destination: TVShowDetails(tvShow: tvShow)) {
            Group {
                TVShowPosterImage(for: tvShow)
            }
        }
    }
}

struct TVShowCell_Previews: PreviewProvider {
    static var previews: some View {
        TVShowCell(for: TVShow(id: 1402,
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
                                  posterPath: "/5l10EjdgPxu8Gbl5Ww6SWkVQH6T.jpg",
                                  backdropPath: "/wXXaPMgrv96NkH8KD1TMdS2d7iq.jpg",
                                  firstAirDate: "2010-10-31"))
    }
}
