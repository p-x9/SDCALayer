//
//  CGColor+ICodable.swift
//  
//
//  Created by p-x9 on 2022/11/09.
//  
//

import QuartzCore

extension CGColor: IndirectlyCodable {
    public typealias Target = JCGColor

    public func applyProperties(to layer: JCGColor) {}

    public func codable() -> JCGColor? {
        JCGColor(code: self.rgbString)
    }
}
