//
//  UIApplication.swift
//  Notflix
//
//  Created by Quentin Eude on 18/05/2020.
//  Copyright © 2020 Quentin Eude. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter { $0.isKeyWindow }
            .first?
            .endEditing(force)
    }
}
