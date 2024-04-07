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

open class JCAAnimation: CAAnimationConvertible, Codable {
    public typealias Target = CAAnimation

    open class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: PropertyMap<CAAnimation, JCAAnimation> = .init([
        .init(\.beginTime, \.beginTime),
        .init(\.duration, \.duration),
        .init(\.speed, \.speed),
        .init(\.timeOffset, \.timeOffset),
        .init(\.repeatCount, \.repeatCount),
        .init(\.repeatDuration, \.repeatDuration),
        .init(\.autoreverses, \.autoreverses),
        .init(\.fillMode, \.fillMode),

        .init(\.timingFunction, \.timingFunction),
        .init(\.isRemovedOnCompletion, \.isRemovedOnCompletion)
    ])

    /* CAMediaTiming */
    public var beginTime: CFTimeInterval?
    public var duration: CFTimeInterval?
    public var speed: Float?
    public var timeOffset: CFTimeInterval?
    public var repeatCount: Float?
    public var repeatDuration: CFTimeInterval?
    public var autoreverses: Bool?
    public var fillMode: JCAMediaTimingFillMode?

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

    public func convertToAnimation() -> Target? {
        let animation = CAAnimation()

        self.applyProperties(to: animation)
        return animation
    }
}

public final class JCAMediaTimingFillMode: RawIndirectlyCodableModel {
    public typealias Target = CAMediaTimingFillMode

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}
