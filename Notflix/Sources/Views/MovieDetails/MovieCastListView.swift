//
//  MovieCastListView.swift
//  Notflix
//
//  Created by Quentin Eude on 16/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct MovieCastListView: View {
    @ObservedObject private var movieCastViewModel: MovieCastViewModel

    init(movieId: Int) {
        self.movieCastViewModel = MovieCastViewModel(movieId: movieId)
    }

    var body: some View {
        Group {
            if self.movieCastViewModel.state != .loading {
                VStack(alignment: .leading, spacing: 10) {
                    Text(L10n.Movie.Details.Cast.list)
                        .padding(.leading, 16)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            Group {
                                ForEach(movieCastViewModel.actors) { actor in
                                    self.cellFor(actor: actor)
                                }
                            }
                        }
                        .frame(height: 170)
                        .padding([.leading, .trailing], 10)
                    }
                }
            } else {
                VStack(alignment: .leading, spacing: 10) {
                    ShimmerView().frame(height: 32)
                    ShimmerView().frame(height: 170)
                }.padding([.leading, .trailing], 10)
            }
        }
    }

    func cellFor(actor: Actor) -> some View {
        return Group {
            if actor.profileUrl != nil {
                VStack(alignment: .center, spacing: 16) {
                    AsyncImage(url: actor.profileUrl!,
                               configuration: {AnyView($0.resizable().scaledToFill())},
                               defaultView: {
                                AnyView(
                                    ShimmerView()
                                )
                    })
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                    Text(actor.name).foregroundColor(.white)
                }
            } else {
               VStack(alignment: .center, spacing: 16) {
                Color.darkerGray
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                Text(actor.name).foregroundColor(.white)
                }
            }
        }
    }
}

struct MovieCastListView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            MovieCastListView(movieId: 330457)
        }
    }
}
