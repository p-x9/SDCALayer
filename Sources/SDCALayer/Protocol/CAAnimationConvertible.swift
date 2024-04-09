//
//  CAAnimationConvertible.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore

public protocol CAAnimationConvertible: IndirectlyCodableModel where Target: CAAnimation {
    func convertToAnimation() -> Target?
}

public extension CAAnimationConvertible {
    func converted() -> Target? {
        self.convertToAnimation()
    }
}

