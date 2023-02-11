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

    public func codable() -> JCALayer? {
        guard let layerClass = NSClassFromString(Self.codableTypeName) as? JCALayer.Type else {
            return nil
        }

        return layerClass.init(with: self)
    }

    @objc
    open class var codableTypeName: String {
        String(reflecting: Target.self)
    }
}

extension CALayerCornerCurve: IndirectlyCodable {
    public typealias Target = JCALayerCornerCurve

    public func codable() -> JCALayerCornerCurve? {
        .init(with: self)
    }
}

extension CACornerMask: IndirectlyCodable {
    public typealias Target = JCACornerMask

    public func codable() -> JCACornerMask? {
        .init(with: self)
    }
}
