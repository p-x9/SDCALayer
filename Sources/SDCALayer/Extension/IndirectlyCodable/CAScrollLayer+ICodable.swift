//
//  CAScrollLayer+ICodable.swift
//  
//
//  Created by p-x9 on 2022/11/15.
//  
//

import QuartzCore

extension CAScrollLayer {
    public typealias Model = JCAScrollLayer

    open override class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}

extension CAScrollLayerScrollMode: RawIndirectlyCodable {
    public typealias Model = JCAScrollLayerScrollMode
}
