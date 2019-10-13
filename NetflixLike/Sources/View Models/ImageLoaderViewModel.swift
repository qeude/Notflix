//
//  ImageLoaderViewModel.swift
//  NetflixLike
//
//  Created by Quentin Eude on 13/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoaderViewModel: ObservableObject {
    
    @Published var data: Data = Data()
    @Published var isLoading: Bool = false
    
    init(imageUrl: String) {
        self.isLoading = true
        _ = APIService().fetchImage(imageUrl: imageUrl).done { result in
            self.data = result
            self.isLoading = false
        }
    }
    
    let didChange = PassthroughSubject<ImageLoaderViewModel, Never>()
}
