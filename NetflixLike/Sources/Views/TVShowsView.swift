//
//  TVShowsView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI
import CocoaLumberjack

struct TVShowsView: View {
    @ObservedObject var tvShowsViewModel: TVShowsViewModel

    var listName: String

    init(tvShowsViewModel: TVShowsViewModel, listName: String = "") {
        self.tvShowsViewModel = tvShowsViewModel
        self.listName = listName
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(listName)
                .padding(.leading, 10)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(tvShowsViewModel.tvShows) { tvShow in
                        AsyncImage(url: tvShow.posterUrl!, configuration: {$0.resizable()})
                            .frame(width: 110, height: 180)
                            .cornerRadius(8.0)
                    }
                }
                .frame(height: 190)
                .padding(.leading, 10)
            }
        }

    }
}

struct TVShowsView_Previews: PreviewProvider {
    static var previews: some View {
         ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            TVShowsView(tvShowsViewModel: TVShowsViewModel(fetcher: APIEndpoints.popularTVShows), listName: "Popular TV Shows")
        }
    }
}
