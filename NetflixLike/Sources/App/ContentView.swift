//
//  ContentView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 07/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var movieListViewModel = MovieListViewModel()

    var body: some View {
        NavigationView {
            List(self.movieListViewModel.popularMovies) { item in
                ListRowView(movie: item).onAppear {
                    let currIndex = self.movieListViewModel.popularMovies.firstIndex { movie -> Bool in
                        movie.title == item.title
                    }
                    self.getNextPageIfNecessary(encounteredIndex: currIndex ?? -1 )
                }
            }.navigationBarTitle(Text("Popular movies"))
        }
    }

    private func getNextPageIfNecessary(encounteredIndex: Int) {
        guard encounteredIndex == self.movieListViewModel.popularMovies.count - 10 else { return }
        self.movieListViewModel.nextPage()
    }
}

struct ListRowView: View {
    let movie: Movie

    var body: some View {
        VStack (alignment: .leading) {
            PosterImageView(imageUrl: movie.posterPath!)
            Text(movie.title).bold()
        }
    }
}

struct PosterImageView: View {
    @ObservedObject var imageLoader: ImageLoaderViewModel

    @State var spinCircle = false
    init(imageUrl: String) {
        imageLoader = ImageLoaderViewModel(imageUrl: imageUrl)
    }

    var body: some View {
        // TODO: Add default image
        if imageLoader.isLoading {
           return AnyView(
            ZStack {
                Circle()
                    .trim(from: 0.5, to: 1)
                    .stroke(Color.blue, lineWidth: 4)
                    .frame(width: 100)
                    .rotationEffect(.degrees(spinCircle ? 0 : -360), anchor: .center)
                    .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false))
                    .frame(width: 250, height: 375)
            }.onAppear {
                self.spinCircle = true
            }
           )
        } else {
            return AnyView(Image(uiImage: (UIImage(data: imageLoader.data)) ?? UIImage(named: "image")!)
                .resizable()
                .frame(width: 250, height: 375)
                .clipped())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
