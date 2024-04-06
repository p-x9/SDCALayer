//
//  JCAAnimation.swift
//
//
//  Created by p-x9 on 2024/04/06.
//  
//

import Foundation
import QuartzCore
import KeyPathValue
import IndirectlyCodable

open class JCAAnimation: IndirectlyCodableModel, Codable {
    public typealias Target = CAAnimation

    open class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: PropertyMap<CAAnimation, JCAAnimation> = .init([
        .init(\.timingFunction, \.timingFunction),
        .init(\.isRemovedOnCompletion, \.isRemovedOnCompletion)
    ])

    public var timingFunction: JCAMediaTimingFunction?
    public var isRemovedOnCompletion: Bool?

    public init() {}

    public required convenience init(with object: Target) {
        self.init()
        applyProperties(with: object)
    }

    open func applyProperties(to target: Target) {
        Self.propertyMap.apply(to: target, from: self)
    }

    open func applyProperties(with target: Target) {
        Self.propertyMap.apply(to: self, from: target)
    }

    public func converted() -> Target? {
        let animation = CAAnimation()

        self.applyProperties(to: animation)
        return animation
    }
}

