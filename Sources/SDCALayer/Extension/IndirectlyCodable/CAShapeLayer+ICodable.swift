//
//  CAShapeLayer+ICodable.swift
//  
//
//  Created by p-x9 on 2022/11/11.
//  
//

import QuartzCore

extension CAShapeLayer {
    public typealias Model = JCAShapeLayer

    open override class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}

extension CAShapeLayerFillRule: RawIndirectlyCodable {
    public typealias Model = JCAShapeLayerFillRule
}

extension CAShapeLayerLineCap: RawIndirectlyCodable {
    public typealias Model = JCAShapeLayerLineCap
}

extension CAShapeLayerLineJoin: RawIndirectlyCodable {
    public typealias Model = JCAShapeLayerLineJoin
}
