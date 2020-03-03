//
//  TVShowsView.swift
//  NetflixLike
//
//  Created by Quentin Eude on 02/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import SwiftUI

struct TVShowsView: View {
    var body: some View {
//        Text("TVShowsView").foregroundColor(.white)
        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")!)
    }
}

struct TVShowsView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowsView()
    }
}
