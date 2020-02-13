//
//  Collection+Optional.swift
//
//  Created by Soheil Novinfard on 03/02/2020.
//  Copyright © 2020 Novinfard. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Iterator.Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }
}
