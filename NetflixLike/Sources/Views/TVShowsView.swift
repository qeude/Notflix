//
//  TVShowsView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 13/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct TVShowsView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 25) {
                HorizontalTVShowsListView(tvShowsViewModel: TVShowsViewModel(fetcher: APIEndpoints.popularTVShows), listName: L10n.Tvshows.Popular.title)
                HorizontalTVShowsListView(tvShowsViewModel: TVShowsViewModel(fetcher: APIEndpoints.topRatedTVShows), listName: L10n.Tvshows.Toprated.title)
                HorizontalTVShowsListView(tvShowsViewModel: TVShowsViewModel(fetcher: APIEndpoints.popularTVShows), listName: L10n.Tvshows.Popular.title)
                HorizontalTVShowsListView(tvShowsViewModel: TVShowsViewModel(fetcher: APIEndpoints.topRatedTVShows), listName: L10n.Tvshows.Toprated.title)
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
