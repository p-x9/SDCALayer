//
//  CABasicAnimation+ICodable.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore

extension CABasicAnimation {
    public typealias Model = JCABasicAnimation

    open override class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}
