//
//  ImageLoaderViewModel.swift
//  Notflix
//
//  Created by Quentin Eude on 13/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import CocoaLumberjack

class ImageCache {
    var cache = NSCache<NSString, UIImage>()

    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }

    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}

class ImageLoaderViewModel: ObservableObject {
    @Published var image: UIImage?

    private var cache = ImageCache.getImageCache()
    private var cancellable: AnyCancellable?
    private(set) var isLoading = false
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")

    private let url: URL

    init(url: URL) {
        self.url = url
    }

    func load() {
        guard !isLoading else {return}

        if loadImageFromCache() {
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: ImageLoaderViewModel.imageProcessingQueue)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [unowned self] _ in self.onStart() },
                          receiveOutput: { [unowned self] in self.cache($0) },
                          receiveCompletion: { [unowned self] _ in self.onFinish() },
                          receiveCancel: { [unowned self] in self.onFinish() })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    func loadImageFromCache() -> Bool {
        guard let cacheImage = cache.get(forKey: url.absoluteString) else {
            DDLogDebug("not found in cache")
            return false
        }

        DDLogDebug("Hit from cache")
        image = cacheImage
        return true
    }

    private func onStart() {
        isLoading = true
    }

    private func onFinish() {
        isLoading = false
    }

    private func cache(_ image: UIImage?) {
        guard let image = image else {
            return
        }
        self.cache.set(forKey: self.url.absoluteString, image: image)
    }

    func cancel() {
        cancellable?.cancel()
    }
}
