//
//  Color.swift
//  ColorPicker
//
//  Created by Gerardo Hernandez on 2/5/20.
//  Copyright © 2020 Gerardo Hernandez. All rights reserved.
//

import UIKit

struct Color {
    static func getHueSaturation(at offset: CGPoint) -> (hue: CGFloat, saturation: CGFloat) {
        guard offset != CGPoint.zero else {
            return (hue: 0, saturation: 0)
        }
        let saturation = sqrt(offset.x * offset.x + offset.y * offset.y)
        var hue = acos(offset.x / saturation) / (2.0 * CGFloat.pi)
        
        if offset.y < 0 {
            hue = 1.0 - hue
        }
        return (hue: hue, saturation: saturation)
    }
}
