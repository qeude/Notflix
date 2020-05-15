//
//  HorizontalMoviesListView.swift
//  Notflix
//
//  Created by Quentin Eude on 14/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct HorizontalMoviesListView: View {
   @ObservedObject var horizontalMoviesListViewModel: HorizontalMoviesListViewModel

        var listName: String

        init(horizontalMoviesListViewModel: HorizontalMoviesListViewModel, listName: String = "") {
            self.horizontalMoviesListViewModel = horizontalMoviesListViewModel
            self.listName = listName
        }

        var body: some View {
            Group {
                if horizontalMoviesListViewModel.state == .loading {
                    VStack(alignment: .leading, spacing: 10) {
                        ShimmerView().frame(height: 32)
                        ShimmerView().frame(height: 245)
                    }.padding([.leading, .trailing], 10)
                } else {
                    if !horizontalMoviesListViewModel.movies.isEmpty {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(listName)
                                .padding(.leading, 16)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(horizontalMoviesListViewModel.movies) { movie in
                                        MovieCell(for: movie)
                                    }
                                }
                                .frame(height: 245)
                                .padding(.leading, 10)
                            }
                        }
                    } else {
                        Rectangle().fill(Color.clear)
                    }
                }
            }.transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
        }
    }
struct HorizontalMoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            HorizontalMoviesListView(horizontalMoviesListViewModel: HorizontalMoviesListViewModel(fetcher: APIEndpoints.popularMovies),
                                     listName: "Popular Movies")
        }
    }
}
