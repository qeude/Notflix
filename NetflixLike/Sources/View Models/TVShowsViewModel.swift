//
//  TVShowsViewModel.swift
//  NetflixLike
//
//  Created by Quentin Eude on 03/03/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import Combine
import CocoaLumberjack

class TVShowsViewModel: ObservableObject {
    @Published var tvShows = [TVShow]()

    private var disposables = Set<AnyCancellable>()
}
