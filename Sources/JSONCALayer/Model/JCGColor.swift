//
//  JCGColor.swift
//  
//
//  Created by p-x9 on 2022/11/06.
//  
//

import Foundation
import QuartzCore

public class JCGColor: ObjectConvertiblyCodable {
    public typealias Target = CGColor

    let code: String?

    init(code: String) {
        self.code = code
    }

    public required init(with object: CGColor) {
        code = object.rgbString
    }

    public func converted() -> CGColor? {
        guard let code else { return nil }
        return CGColor.color(rgb: code)
    }
}
