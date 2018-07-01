//
//  ShapeType.swift
//  GeometryFighter
//
//  Created by chenzhipeng on 2018/6/30.
//  Copyright © 2018 perry. All rights reserved.
//

import Foundation

enum ShapeType: Int {
    case box = 0
    case sphere
    case pyramid
    case torus
    case capsule
    case cylinder
    case cone
    case tube
    
    // generate a random ShapeType.
    static func random() -> ShapeType {
        let maxValue = tube.rawValue
        let rand = arc4random_uniform(UInt32(maxValue + 1))
        return ShapeType(rawValue: Int(rand))!
    }
}
