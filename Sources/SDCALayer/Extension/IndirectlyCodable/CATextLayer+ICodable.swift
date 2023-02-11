//
//  CATextLayer+ICodable.swift
//  
//
//  Created by p-x9 on 2022/11/14.
//  
//

import QuartzCore

extension CATextLayer {
    public typealias Target = JCATextLayer

    open override class var codableTypeName: String {
        String(reflecting: Target.self)
    }
}

extension CATextLayerTruncationMode: IndirectlyCodable {
    public typealias Target = JCATextLayerTruncationMode

    public func codable() -> JCATextLayerTruncationMode? {
        .init(with: self)
    }
}

extension CATextLayerAlignmentMode: IndirectlyCodable {
    public typealias Target = JCATextLayerAlignmentMode

    public func codable() -> JCATextLayerAlignmentMode? {
        .init(with: self)
    }
}
