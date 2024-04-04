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

extension CALayerCornerCurve: RawIndirectlyCodable {
    public typealias Model = JCALayerCornerCurve
}

extension CACornerMask: RawIndirectlyCodable {
    public typealias Model = JCACornerMask
}

extension CALayerContentsGravity: RawIndirectlyCodable {
    public typealias Model = JCALayerContentsGravity
}

extension CALayerContentsFormat: RawIndirectlyCodable {
    public typealias Model = JCALayerContentsFormat
}

extension CALayerContentsFilter: RawIndirectlyCodable {
    public typealias Model = JCALayerContentsFilter
}

extension CAEdgeAntialiasingMask: RawIndirectlyCodable {
    public typealias Model = JCAEdgeAntialiasingMask
}

