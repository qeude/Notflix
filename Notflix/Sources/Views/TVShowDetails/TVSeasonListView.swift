//
//  SeasonListView.swift
//  Notflix
//
//  Created by Quentin Eude on 11/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct TVSeasonListView: View {
    @ObservedObject private var tvSeasonListViewModel: TVSeasonListViewModel

    let tvSeasonName: String
    init(tvShowId: Int, tvSeason: TVSeason) {
        self.tvSeasonName = tvSeason.name
        self.tvSeasonListViewModel = TVSeasonListViewModel(tvShowId: tvShowId, tvSeasonNumber: tvSeason.seasonNumber)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if !self.tvSeasonListViewModel.episodes.isEmpty {
                Group {
                    Text(self.tvSeasonName).font(.system(size: 32, weight: .bold))
                    ForEach (self.tvSeasonListViewModel.episodes.sorted { $0.episodeNumber > $1.episodeNumber }, id: \.id) { episode in
                        HStack(alignment: .top, spacing: 10) {
                            ZStack(alignment: .center) {
                                Group {
                                    if episode.stillUrl != nil {
                                        AsyncImage(url: episode.stillUrl!,
                                                   configuration: {AnyView($0.resizable())},
                                                   defaultView: {
                                                    AnyView(
                                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                                            .fill(Color.darkGray)
                                                    )
                                        }
                                        )
                                            .frame(width: 150, height: 90)
                                            .aspectRatio(contentMode: .fit)
                                            .cornerRadius(16)
                                    } else {
                                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                                            .fill(Color.darkGray)
                                            .frame(width: 150, height: 90)
                                    }
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(episode.name ?? "").font(.system(size: 20, weight: .semibold))
                                Text("Episode \(episode.episodeNumber)").font(.system(size: 14, weight: .medium))
                                Text(episode.overview ?? "")
                                    .lineLimit(3)
                                    .multilineTextAlignment(.leading)
                                    .font(.system(size: 10, weight: .medium))
                                    .padding(.top, 8)
                            }
                        }.frame(height: 100)}

                }
            } else {
                Group {
                    ShimmerView().frame(height: 40)
                    ForEach((1...5), id: \.self) { _ in
                        ShimmerView().frame(height: 100)
                    }
                }
            }
        }
        .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
        .padding(.bottom, 40)
    }
}

struct TVSeasonListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            TVSeasonListView(tvShowId: 1402,
                             tvSeason: TVSeason(id: 3643,
                                                name: "Season 1",
                                                overview: "Rick Grimes embarks on a survivalist.",
                                                seasonNumber: 1, posterPath: "/yaOB2Y8GcoXwjNQ3apq67bMbNHF.jpg"))
        }
    }
}
