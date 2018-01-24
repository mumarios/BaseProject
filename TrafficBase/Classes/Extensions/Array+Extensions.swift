//
//  Array+Extensions.swift
//  BaseProject
//
//  Created by Waqas Ali on 29/12/2017.
//  Copyright © 2017 Waqas Ali. All rights reserved.
//

import Foundation


extension Array {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript(safe index: Int ) -> Element? {
        return indices.contains(index) ? self[index] : nil  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    }
}
