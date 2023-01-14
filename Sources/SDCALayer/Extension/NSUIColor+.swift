//
//  NSUIColor+.swift
//  
//
//  Created by p-x9 on 2022/11/23.
//  
//

import Foundation

extension NSUIColor {
    /// rgb color code
    var rgbString: String {
        var red: CGFloat = -1
        var blue: CGFloat = -1
        var green: CGFloat = -1
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        let rgb: [CGFloat] = [red, green, blue]
        return rgb.reduce(into: "") { res, value in
            let intval = Int(round(value * 255))
            res += (NSString(format: "%02X", intval) as String)
        }
    }

    /// rgba color code
    var rgbaString: String {
        var red: CGFloat = -1
        var blue: CGFloat = -1
        var green: CGFloat = -1
        var alpha: CGFloat = 1
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let rgba: [CGFloat] = [red, green, blue, alpha]
        return rgba.reduce(into: "") { res, value in
            let intval = Int(round(value * 255))
            res += (NSString(format: "%02X", intval) as String)
        }
    }
}
