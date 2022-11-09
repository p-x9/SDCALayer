//
//  CALayer+ICodable.swift
//  
//
//  Created by p-x9 on 2022/11/09.
//  
//

import QuartzCore

extension CALayer: IndirectlyCodable {
    public typealias Target = JCALayer

    static private var prefix: String {
        NSStringFromClass(JCALayer.self).components(separatedBy: ".")[0]
    }

    public func codable() -> JCALayer? {
        let className = "\(type(of: self))"
        guard let layerClass = NSClassFromString(Self.prefix + ".J" + className) as? JCALayer.Type else {
            return nil
        }

        return layerClass.init(with: self)
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
