//
//  SeasonListView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 11/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct TVSeasonListView: View {
    @ObservedObject private var tvSeasonListViewModel: TVSeasonListViewModel

    init(tvShowId: Int, tvSeasonNumber: Int) {
        self.tvSeasonListViewModel = TVSeasonListViewModel(tvShowId: tvShowId, tvSeasonNumber: tvSeasonNumber)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach (self.tvSeasonListViewModel.episodes.sorted { $0.episodeNumber > $1.episodeNumber }, id: \.id) { episode in
                HStack(alignment: .top, spacing: 10) {
                    ZStack(alignment: .center) {
                        Group {
                            if episode.stillUrl != nil {
                                AsyncImage(url: episode.stillUrl!,
                                           configuration: {$0.resizable()},
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
                }.frame(height: 100)
            }
        }
    }
}

struct TVSeasonListView_Previews: PreviewProvider {
    static var previews: some View {
        TVSeasonListView(tvShowId: 1402, tvSeasonNumber: 1)
    }
}
