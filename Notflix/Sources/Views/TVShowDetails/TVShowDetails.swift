//
//  TVShowDetails.swift
//  Notflix
//
//  Created by Quentin Eude on 19/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI
import CocoaLumberjack
import Combine

struct TVShowDetails: View {
    @ObservedObject private var tvShowDetailsViewModel: TVShowDetailsViewModel
    private var firstAirYear: String?

    init(tvShowId: Int) {
        UIScrollView.appearance().bounces = false
        self.tvShowDetailsViewModel = TVShowDetailsViewModel(tvShowId: tvShowId)
        let calendar = Calendar.current
        if let formattedFirstAirDate = self.tvShowDetailsViewModel.tvShow?.formattedFirstAirDate {
            self.firstAirYear = String(calendar.component(.year, from: formattedFirstAirDate))
        }
    }

    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 10) {
                    header
                    episodes
                    recommendations
                }
            }.edgesIgnoringSafeArea(.all)
                .foregroundColor(.white)
        }
    }

    var header: some View {
        ZStack {
            headerBackground
            headerForeground
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 620, alignment: .topLeading)
        .padding(.bottom, 20)
        .clipped()
    }

    var headerBackground: some View {
        Group {
            self.tvShowDetailsViewModel.tvShow.map { tvShow in
                Group {
                    if tvShow.posterUrl != nil {
                        AsyncImage(url: tvShow.posterUrl!,
                                   configuration: {
                                    AnyView(
                                        AnyView($0.resizable())
                                            .scaledToFit()
                                            .blur(radius: 25, opaque: true)
                                    )
                        },
                                   defaultView: {
                                    AnyView(
                                        Rectangle()
                                            .fill(Color.darkerGray)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                                    )
                        })
                    } else {
                        Color.darkerGray
                    }
                }
            }
        }
    }

    var headerForeground: some View {
        Group {
            self.tvShowDetailsViewModel.tvShow.map { tvShow in
                VStack(alignment: .center, spacing: 20) {
                    TVShowPosterImage(for: tvShow)
                    Text(tvShow.title)
                        .font(.system(size: 32, weight: .bold))
                    HStack(alignment: .center, spacing: 60) {
                        Text(String(format: "%.1f", tvShow.voteAverage)).fontWeight(.semibold)
                        //                Text(self.firstAirYear!).fontWeight(.semibold)
                    }
                    Text(tvShow.overview ?? "")
                        .font(.system(size: 16, weight: .regular))
                        .lineLimit(8)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 30)
                }
            }
        }
    }

    var episodes: some View {
        Group {
            self.tvShowDetailsViewModel.tvShow.map { tvShow in
                tvShow.seasons.map { tvSeasons in
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(tvSeasons.sorted {$0.seasonNumber > $1.seasonNumber}, id: \.id) { season in
                                TVSeasonListView(tvShowId: tvShow.id, tvSeason: season)
                        }
                    }
                }
            }
        }.padding(.all, 16)
    }

    var recommendations: some View {
        Group {
            self.tvShowDetailsViewModel.tvShow.map { tvShow in
                HorizontalTVShowsListView(tvShowsViewModel: HorizontalTVShowsListViewModel(fetcher: APIEndpoints.recommendationsTVShows(tvShowId: tvShow.id)),
                                          listName: L10n.Tvshow.Details.recommendations)
            }
        }
        .padding(.bottom, 80)
    }
}

struct TVShowDetails_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            TVShowDetails(tvShowId: 1402)
        }
    }
}
