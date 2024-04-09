//
//  CAPropertyAnimation+ICodable.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore

extension CAPropertyAnimation {
    public typealias Model = JCAPropertyAnimation

    open override class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}
