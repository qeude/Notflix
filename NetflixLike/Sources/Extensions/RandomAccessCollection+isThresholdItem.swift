//
//  RandomAccessCollection+isLastItem.swift
//  NetflixLike
//
//  Created by Quentin Eude on 09/10/2019.
//  Copyright © 2019 Quentin Eude. All rights reserved.
//

import Foundation
extension RandomAccessCollection where Self.Element: Identifiable {
   func isThresholdItem<Item: Identifiable>(offset: Int,
                                             item: Item) -> Bool {
        guard !isEmpty else {
            return false
        }
        
        guard let itemIndex = firstIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        
        let distance = self.distance(from: itemIndex, to: endIndex)
        let offset = offset < count ? offset : count - 1
        return offset == (distance - 1)
    }
}
