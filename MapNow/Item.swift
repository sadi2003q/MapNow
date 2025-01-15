//
//  Item.swift
//  MapNow
//
//  Created by  Sadi on 15/01/2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
