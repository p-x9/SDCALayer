//
//  CAReplicatorLayer+ICodable.swift
//
//
//  Created by p-x9 on 2024/04/04.
//  
//

import Foundation
import QuartzCore

extension CAReplicatorLayer {
    public typealias Model = JCAReplicatorLayer

    open override class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}
