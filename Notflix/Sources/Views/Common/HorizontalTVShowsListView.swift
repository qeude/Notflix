//
//  TVShowsView.swift
//  Notflix
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI
import CocoaLumberjack

struct HorizontalTVShowsListView: View {
    @ObservedObject var tvShowsViewModel: HorizontalTVShowsListViewModel

    var listName: String

    init(tvShowsViewModel: HorizontalTVShowsListViewModel, listName: String = "") {
        self.tvShowsViewModel = tvShowsViewModel
        self.listName = listName
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(listName)
                .padding(.leading, 16)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(tvShowsViewModel.tvShows) { tvShow in
                        TVShowCell(for: tvShow)
                    }
                }
                .frame(height: 245)
                .padding(.leading, 10)
            }
        }

    }
}

struct HorizontalTVShowsListView_Previews: PreviewProvider {
    static var previews: some View {
         ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            HorizontalTVShowsListView(tvShowsViewModel: HorizontalTVShowsListViewModel(fetcher: APIEndpoints.popularTVShows),
                                      listName: "Popular TV Shows")
        }
    }
}
