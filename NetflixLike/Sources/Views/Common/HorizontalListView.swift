//
//  HorizontalListView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 07/11/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import SwiftUI

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
