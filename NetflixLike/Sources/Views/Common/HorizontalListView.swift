//
//  HorizontalListView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 07/11/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import SwiftUI

//struct ContentView: View {
//    let url = URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!
//    let cache = TemporaryImageCache()
//    @State var numberOfRows = 0
//
//    var body: some View {
//        NavigationView {
//            list.navigationBarItems(trailing: addButton)
//        }
//    }
//
//    private var list: some View {
//        List(0..<numberOfRows, id: \.self) { _ in
//            AsyncImage(url: self.url, placeholder: Text("Loading ..."), cache: self.cache)
//                .frame(minHeight: 200, maxHeight: 200)
//                .aspectRatio(2 / 3, contentMode: .fit)
//        }
//    }
//
//    private var addButton: some View {
//        Button(action: { self.numberOfRows += 1 }) { Image(systemName: "plus") }
//    }
//}

struct HorizontalListView: View {
    let moviesList: [Movie]!

    init(_ moviesList: [Movie]) {
        self.moviesList = moviesList
    }

    var body: some View {
        Text("bonjour")
//        ScrollView(.horizontal) {
////            HStack(spacing: 8) {
//////                ForEach(self.moviesList) { item in
//////                    PosterImageView(imageUrl: item.posterPath!)
//////                }
////            }
//            .padding(.leading, 16)
//        }
//        .frame(height: 150)
    }
}

// swiftlint:disable line_length
struct HorizontalListView_Previews: PreviewProvider {
    static var previews: some View {
        let movieList = [
            Movie(id: 290859, title: "Joker", overview: "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.", popularity: 439.564, voteAverage: 8.5, video: false, adult: false, voteCount: 4901, genreIds: [80, 18, 53], posterPath: "/vqzNJRH4YyquRiWxCCOH0aXggHI.jpg", backdropPath: "/rtf4vjjLZLalpOzDUi0Qd2GTUqq.jpg", releaseDate: "2019-10-04"),
            Movie(id: 290859, title: "Joker", overview: "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.", popularity: 439.564, voteAverage: 8.5, video: false, adult: false, voteCount: 4901, genreIds: [80, 18, 53], posterPath: "/vqzNJRH4YyquRiWxCCOH0aXggHI.jpg", backdropPath: "/rtf4vjjLZLalpOzDUi0Qd2GTUqq.jpg", releaseDate: "2019-10-04"),
            Movie(id: 290859, title: "Joker", overview: "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.", popularity: 439.564, voteAverage: 8.5, video: false, adult: false, voteCount: 4901, genreIds: [80, 18, 53], posterPath: "/vqzNJRH4YyquRiWxCCOH0aXggHI.jpg", backdropPath: "/rtf4vjjLZLalpOzDUi0Qd2GTUqq.jpg", releaseDate: "2019-10-04"),
            Movie(id: 290859, title: "Joker", overview: "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.", popularity: 439.564, voteAverage: 8.5, video: false, adult: false, voteCount: 4901, genreIds: [80, 18, 53], posterPath: "/vqzNJRH4YyquRiWxCCOH0aXggHI.jpg", backdropPath: "/rtf4vjjLZLalpOzDUi0Qd2GTUqq.jpg", releaseDate: "2019-10-04")
        ]
        return HorizontalListView(movieList)
    }
}
