//
//  PosterImageView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 07/11/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import SwiftUI

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
                    .rotationEffect(.degrees(spinCircle ? 0 : -360), anchor: .center)
                    .animation(Animation.linear(duration: 0.5).repeatForever(autoreverses: false))
                    .frame(width: 100, height: 150)
            }.onAppear {
                self.spinCircle = true
            }
           )
        } else {
            return AnyView(Image(uiImage: (UIImage(data: imageLoader.data)) ?? UIImage(named: "image")!)
                .resizable()
                .frame(width: 100, height: 150)
                .clipped())
        }
    }
}

struct PosterImageView_Previews: PreviewProvider {
    static var previews: some View {
        PosterImageView(imageUrl: "https://image.tmdb.org/t/p/original/nGRme8fNDnVDZBD51sc7u95ERrd.jpg")
    }
}
