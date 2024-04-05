//
//  JCATransformLayer.swift
//
//
//  Created by p-x9 on 2024/04/05.
//  
//

import Foundation
import QuartzCore
import KeyPathValue

open class JCATransformLayer: JCALayer {
    public typealias Target = CATransformLayer

    open override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    open override func convertToLayer() -> CALayer? {
        let layer = CATransformLayer()

        self.applyProperties(to: layer)

        return layer
    }
}
