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

extension CAShapeLayerFillRule: IndirectlyCodable {
    public typealias Model = JCAShapeLayerFillRule

    public func codable() -> JCAShapeLayerFillRule? {
        .init(with: self)
    }
}

extension CAShapeLayerLineCap: IndirectlyCodable {
    public typealias Model = JCAShapeLayerLineCap

    public func codable() -> JCAShapeLayerLineCap? {
        .init(with: self)
    }
}

extension CAShapeLayerLineJoin: IndirectlyCodable {
    public typealias Model = JCAShapeLayerLineJoin

    public func codable() -> JCAShapeLayerLineJoin? {
        .init(with: self)
    }
}
