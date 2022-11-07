//
//  JCGColor.swift
//  
//
//  Created by p-x9 on 2022/11/06.
//  
//

import Foundation
import QuartzCore

class JCGColor: ObjectConvertiblyCodable {
    typealias Target = CGColor

    let code: String?

    func converted() -> CGColor? {
        guard let code else { return nil }
        return CGColor.color(rgb: code)
    }
}
