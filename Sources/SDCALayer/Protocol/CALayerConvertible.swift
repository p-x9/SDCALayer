//
//  CALayerConvertible.swift
//  
//
//  Created by p-x9 on 2022/11/06.
//  
//

import QuartzCore

public protocol CALayerConvertible: IndirectlyCodableModel where Target: CALayer {
    func convertToLayer() -> Target?
}

public extension CALayerConvertible {
    func converted() -> Target? {
        self.convertToLayer()
    }
}
