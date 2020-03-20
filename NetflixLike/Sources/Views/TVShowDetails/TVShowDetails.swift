//
//  TVShowDetails.swift
//  NetflixLike
//
//  Created by Quentin Eude on 19/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI
import CocoaLumberjack

struct TVShowDetails: View {
    private let tvShow: TVShow
    private var firstAirYear: String?

    init(tvShow: TVShow) {
        self.tvShow = tvShow
        let calendar = Calendar.current
        if let formattedFirstAirDate = self.tvShow.formattedFirstAirDate {
            self.firstAirYear = String(calendar.component(.year, from: formattedFirstAirDate))
        }
    }

    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: true) {
                header
            }.edgesIgnoringSafeArea(.all)
                .foregroundColor(.white)
        }
    }

    var header: some View {
        VStack(alignment: .center, spacing: 20) {
            TVShowPosterImage(for: tvShow)
            Text(tvShow.title)
                .font(.system(size: 32, weight: .bold))
            HStack(alignment: .center, spacing: 60) {
                Text(String(format: "%.1f", tvShow.voteAverage)).fontWeight(.semibold)
                Text(self.firstAirYear!).fontWeight(.semibold)
            }.frame(maxWidth: .infinity)
            Text(tvShow.overview ?? "")
                .lineLimit(5)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 30)
        }.frame(maxWidth: .infinity)
            .background(
                AsyncImage(url: tvShow.posterUrl!,
                           configuration: {$0.resizable()})
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 20, opaque: true)
        )
            .padding(.top, 70)
            .padding(.bottom, 40)
            .clipped()
    }
}

struct TVShowDetails_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            TVShowDetails(tvShow: TVShow(id: 1402,
                                         title: "The Walking Dead",
                                         // swiftlint:disable:next line_length
                                         overview: "Sheriff's deputy Rick Grimes awakens from a coma to find a post-apocalyptic world dominated by flesh-eating zombies. He sets out to find his family and encounters many other survivors along the way.",
                                         popularity: 124.898,
                                         voteAverage: 7.3,
                                         voteCount: 4607,
                                         genreIds: [10759, 18, 10765],
                                         posterPath: "/5l10EjdgPxu8Gbl5Ww6SWkVQH6T.jpg",
                                         backdropPath: "/wXXaPMgrv96NkH8KD1TMdS2d7iq.jpg",
                                         firstAirDate: "2010-10-31"))
        }
    }
}
