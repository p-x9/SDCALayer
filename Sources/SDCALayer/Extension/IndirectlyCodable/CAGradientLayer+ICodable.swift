//
//  CAGradientLayer+ICodable.swift
//  
//
//  Created by p-x9 on 2022/11/11.
//  
//

import QuartzCore

extension CAGradientLayer {
    public typealias Model = JCAGradientLayer

    open override class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}

extension CAGradientLayerType: RawIndirectlyCodable {
    public typealias Model = JCAGradientLayerType
}
