//
//  CGColor+.swift
//  
//
//  Created by p-x9 on 2022/11/03.
//  
//

import Foundation
import CoreGraphics

extension CGColor {
    static func color(rgb code: String) -> CGColor{
        var color: UInt64 = 0
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        if Scanner(string: code.replacingOccurrences(of: "#", with: "")).scanHexInt64(&color) {
            r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            g = CGFloat((color & 0x00FF00) >>  8) / 255.0
            b = CGFloat( color & 0x0000FF       ) / 255.0
        }
        return CGColor(red: r, green: g, blue: b, alpha: 1.0)
    }

    /// rgb color code
    public var rgbString: String {
        guard let components, components.count >= 3 else {
            return "FFFFFF"
        }

        let rgb: [CGFloat] = Array(components[0..<3])
        return rgb.reduce(into: "") { res, value in
            let intval = Int(round(value * 255))
            res += (NSString(format: "%02X", intval) as String)
        }
    }

    /// rgba color code
    public var rgbaString: String {
        guard let components, components.count >= 4 else {
            return "FFFFFFFF"
        }

        let rgba: [CGFloat] = components
        return rgba.reduce(into: "") { res, value in
            let intval = Int(round(value * 255))
            res += (NSString(format: "%02X", intval) as String)
        }
    }
}
