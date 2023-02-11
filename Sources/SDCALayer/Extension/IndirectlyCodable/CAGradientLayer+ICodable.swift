//
//  CAGradientLayer+ICodable.swift
//  
//
//  Created by p-x9 on 2022/11/11.
//  
//

import QuartzCore

extension CAGradientLayer {
    public typealias Target = JCAGradientLayer

    open override class var codableTypeName: String {
        String(reflecting: Target.self)
    }
}

extension CAGradientLayerType: IndirectlyCodable {
    public typealias Target = JCAGradientLayerType

    public func codable() -> JCAGradientLayerType? {
        .init(with: self)
    }
}
