//
//  CAScrollLayer+ICodable.swift
//  
//
//  Created by p-x9 on 2022/11/15.
//  
//

import QuartzCore

extension CAScrollLayer {
    public typealias Target = JCAScrollLayer

    open override class var codableTypeName: String {
        String(reflecting: Target.self)
    }
}

extension CAScrollLayerScrollMode: IndirectlyCodable {
    public typealias Target = JCAScrollLayerScrollMode

    public func codable() -> JCAScrollLayerScrollMode? {
        .init(with: self)
    }
}
