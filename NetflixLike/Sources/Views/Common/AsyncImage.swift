//
//  AsyncImage.swift
//  NetflixLike
//
//  Created by Quentin Eude on 03/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct AsyncImage: View {
    @ObservedObject private var loader: ImageLoaderViewModel
    @State var shouldAnimate = true
    private let configuration: (Image) -> Image
    private let defaultView: (() -> AnyView?)?

    init(url: URL,
         configuration: @escaping (Image) -> Image = { $0 },
         defaultView: (() -> AnyView?)? = nil ) {
        self.configuration = configuration
        loader = ImageLoaderViewModel(url: url)
        self.defaultView = defaultView
    }
    var body: some View {
        image
    }

    private var image: some View {
        Group {
            if loader.image != nil {
                configuration(Image(uiImage: loader.image!)                    .renderingMode(.original))
            } else {
                if defaultView != nil {
                    defaultView?().onAppear(perform: loader.load)
                    .onDisappear(perform: loader.cancel)
                } else {
                    ActivityIndicator(shouldAnimate: self.$shouldAnimate)
                                              .onAppear(perform: loader.load)
                                              .onDisappear(perform: loader.cancel)
                }
            }
        }
    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")!)
    }
}
