//
//  MovieDetails.swift
//  Notflix
//
//  Created by Quentin Eude on 15/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct MovieDetails: View {
    @ObservedObject private var movieDetailsViewModel: MovieDetailsViewModel

    init(movieId: Int) {
        UIScrollView.appearance().bounces = false
        self.movieDetailsViewModel = MovieDetailsViewModel(movieId: movieId)
    }

    var body: some View {
        ZStack {
            Color(.black).edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 20) {
                    header
                    cast
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
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500, alignment: .topLeading)
//        .padding(.bottom, 10)
        .clipped()
    }

    var headerBackground: some View {
        Group {
            self.movieDetailsViewModel.movie.map { movie in
                Group {
                    if movie.posterUrl != nil {
                        AsyncImage(url: movie.posterUrl!,
                                   configuration: {
                                    AnyView(
                                        AnyView($0.resizable())
                                            .blur(radius: 25, opaque: true)
                                    )
                        },
                                   defaultView: {
                                    AnyView(
                                        Rectangle()
                                            .fill(Color.darkerGray)
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
            self.movieDetailsViewModel.movie.map { movie in
                VStack(alignment: .center, spacing: 20) {
                    MoviePosterImage(for: movie).padding(.top, 50)
                    Text(movie.title)
                        .font(.system(size: 32, weight: .bold)).minimumScaleFactor(0.5)
                    HStack(alignment: .center, spacing: 60) {
                        ZStack {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 40, height: 40)
                                .overlay (
                                    Circle()
                                        .trim(from: 0, to: CGFloat(movie.voteAverage * 0.1))
                                        .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                                        .fill(movie.voteAverage <= 3 ? Color.red : (movie.voteAverage < 7 ? Color.orange : Color.green) )
                            )
                            Text(String(format: "%.1f", movie.voteAverage)).fontWeight(.semibold)
                        }
                        Text(movie.releaseYearToString).fontWeight(.semibold)
                    }
                    Text(movie.overview ?? "")
                        .font(.system(size: 12, weight: .regular))
                        .lineLimit(5)
                        .multilineTextAlignment(.center)
                }.padding([.leading, .trailing, .bottom], 16)
            }
        }
    }

    var cast: some View {
        Group {
            self.movieDetailsViewModel.movie.map { movie in
                MovieCastListView(movieId: movie.id)
            }
        }
    }

    var recommendations: some View {
        Group {
            self.movieDetailsViewModel.movie.map { movie in
                HorizontalMoviesListView(
                    horizontalMoviesListViewModel: HorizontalMoviesListViewModel(fetcher: APIEndpoints.recommendationsMovies(movieId: movie.id)),
                                          listName: L10n.Movie.Details.recommendations)
            }
        }
        .padding(.bottom, 90)
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetails(movieId: 330457)
    }
}
