//
//  CAAnimation+ICodable.swift
//
//
//  Created by p-x9 on 2024/04/06.
//  
//

import QuartzCore
import IndirectlyCodable

extension CAAnimation: IndirectlyCodable {
    public typealias Model = JCAAnimation

    public func codable() -> JCAAnimation? {
        guard let animationClass = NSClassFromString(Self.codableTypeName) as? JCAAnimation.Type else {
            return nil
        }

        return animationClass.init(with: self)
    }

    @objc
    open class var codableTypeName: String {
        String(reflecting: Model.self)
    }
}
