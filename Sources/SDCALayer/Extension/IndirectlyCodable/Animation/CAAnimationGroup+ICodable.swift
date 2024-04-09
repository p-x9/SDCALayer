//
//  CAAnimationGroup+ICodable.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore

extension CAAnimationGroup {
    public typealias Model = JCAAnimationGroup

    open override class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}
