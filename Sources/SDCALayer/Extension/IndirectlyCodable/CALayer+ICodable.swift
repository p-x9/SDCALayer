//
//  CALayer+ICodable.swift
//  
//
//  Created by p-x9 on 2022/11/09.
//  
//

import QuartzCore

extension CALayer: IndirectlyCodable {
    public typealias Model = JCALayer

    public func codable() -> JCALayer? {
        guard let layerClass = NSClassFromString(Self.codableTypeName) as? JCALayer.Type else {
            return nil
        }

        return layerClass.init(with: self)
    }

    @objc
    open class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}

extension CALayerCornerCurve: IndirectlyCodable {
    public typealias Model = JCALayerCornerCurve

    public func codable() -> JCALayerCornerCurve? {
        .init(with: self)
    }
}

extension CACornerMask: IndirectlyCodable {
    public typealias Model = JCACornerMask

    public func codable() -> JCACornerMask? {
        .init(with: self)
    }
}

extension CALayerContentsGravity: IndirectlyCodable {
    public typealias Model = JCALayerContentsGravity

    public func codable() -> Model? {
        .init(with: self)
    }
}

extension CALayerContentsFormat: IndirectlyCodable {
    public typealias Model = JCALayerContentsFormat

    public func codable() -> Model? {
        .init(with: self)
    }
}

extension CALayerContentsFilter: IndirectlyCodable {
    public typealias Model = JCALayerContentsFilter

    public func codable() -> Model? {
        .init(with: self)
    }
}

extension CAEdgeAntialiasingMask: IndirectlyCodable {
    public typealias Model = JCAEdgeAntialiasingMask

    public func codable() -> Model? {
        .init(with: self)
    }
}

