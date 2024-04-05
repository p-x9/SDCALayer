//
//  CATiledLayer+ICodable.swift
//
//
//  Created by p-x9 on 2024/04/05.
//  
//

import QuartzCore

extension CATiledLayer {
    public typealias Model = JCATiledLayer

    open override class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}
