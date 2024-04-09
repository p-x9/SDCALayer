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

extension CATextLayerTruncationMode: RawIndirectlyCodable {
    public typealias Model = JCATextLayerTruncationMode
}

extension CATextLayerAlignmentMode: RawIndirectlyCodable {
    public typealias Model = JCATextLayerAlignmentMode
}
