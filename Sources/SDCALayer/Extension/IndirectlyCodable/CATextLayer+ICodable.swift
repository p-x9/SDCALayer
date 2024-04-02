//
//  CATextLayer+ICodable.swift
//  
//
//  Created by p-x9 on 2022/11/14.
//  
//

import QuartzCore

extension CATextLayer {
    public typealias Model = JCATextLayer

    open override class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}

extension CATextLayerTruncationMode: IndirectlyCodable {
    public typealias Model = JCATextLayerTruncationMode

    public func codable() -> JCATextLayerTruncationMode? {
        .init(with: self)
    }
}

extension CATextLayerAlignmentMode: IndirectlyCodable {
    public typealias Model = JCATextLayerAlignmentMode

    public func codable() -> JCATextLayerAlignmentMode? {
        .init(with: self)
    }
}
