//
//  CASpringAnimation+ICodable.swift
//
//
//  Created by p-x9 on 2024/04/09.
//  
//

import QuartzCore

extension CASpringAnimation {
    public typealias Model = JCASpringAnimation

    open override class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}
