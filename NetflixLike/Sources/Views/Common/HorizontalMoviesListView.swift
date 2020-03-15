//
//  HorizontalMoviesListView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 14/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct HorizontalMoviesListView: View {
    @ObservedObject var moviesViewModel: MoviesViewModel

    var listName: String

    init(moviesViewModel: MoviesViewModel, listName: String = "") {
        self.moviesViewModel = moviesViewModel
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
                    ForEach(moviesViewModel.movies) { movie in
                       MovieCell(for: movie)
                    }
                }
                .frame(height: 190)
                .padding(.leading, 10)
            }
        }
    }
}

struct HorizontalMoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            HorizontalMoviesListView(moviesViewModel: MoviesViewModel(fetcher: APIEndpoints.popularMovies), listName: "Popular Movies")
        }
    }
}
