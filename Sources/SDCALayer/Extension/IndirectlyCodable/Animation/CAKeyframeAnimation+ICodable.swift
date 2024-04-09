//
//  CAKeyframeAnimation+ICodable.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore

extension CAKeyframeAnimation {
    public typealias Model = JCAKeyframeAnimation

    open override class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}

extension CAAnimationCalculationMode: RawIndirectlyCodable {
    public typealias Model = JCAAnimationCalculationMode
}

extension CAAnimationRotationMode: RawIndirectlyCodable {
    public typealias Model = JCAAnimationRotationMode
}
