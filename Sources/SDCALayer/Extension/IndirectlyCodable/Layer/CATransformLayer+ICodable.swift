//
//  CATransformLayer+ICodable.swift
//
//
//  Created by p-x9 on 2024/04/05.
//  
//

import QuartzCore

extension CATransformLayer {
    public typealias Model = JCATransformLayer

    open override class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}
