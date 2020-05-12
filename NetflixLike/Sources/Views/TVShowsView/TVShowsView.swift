//
//  TVShowsView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 13/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct TVShowsView: View {
    @ObservedObject private var tvShowViewModel: TVShowsViewModel

    init() {
        self.tvShowViewModel = TVShowsViewModel()
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 25) {
                HorizontalTVShowsListView(tvShowsViewModel: HorizontalTVShowsListViewModel(fetcher: APIEndpoints.popularTVShows),
                                          listName: L10n.Tvshows.Popular.title)
                HorizontalTVShowsListView(tvShowsViewModel: HorizontalTVShowsListViewModel(fetcher: APIEndpoints.topRatedTVShows),
                                          listName: L10n.Tvshows.Toprated.title)
                ForEach(tvShowViewModel.genres, id: \.id) { genre in
                    HorizontalTVShowsListView(tvShowsViewModel: HorizontalTVShowsListViewModel(fetcher: APIEndpoints.tvShowsForGenres(genreId: genre.id)),
                                              listName: L10n.Tvshows.With.Genre.title(genre.name))
                }
            }
        }
    }
}

struct TVShowsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            TVShowsView()
        }
    }
}
