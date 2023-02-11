//
//  CAShapeLayer+ICodable.swift
//  
//
//  Created by p-x9 on 2022/11/11.
//  
//

import QuartzCore

extension CAShapeLayer {
    public typealias Target = JCAShapeLayer

    open override class var codableTypeName: String {
        String(reflecting: Target.self)
    }
}

extension CAShapeLayerFillRule: IndirectlyCodable {
    public typealias Target = JCAShapeLayerFillRule

    public func codable() -> JCAShapeLayerFillRule? {
        .init(with: self)
    }
}

extension CAShapeLayerLineCap: IndirectlyCodable {
    public typealias Target = JCAShapeLayerLineCap

    public func codable() -> JCAShapeLayerLineCap? {
        .init(with: self)
    }
}

extension CAShapeLayerLineJoin: IndirectlyCodable {
    public typealias Target = JCAShapeLayerLineJoin

    public func codable() -> JCAShapeLayerLineJoin? {
        .init(with: self)
    }
}
