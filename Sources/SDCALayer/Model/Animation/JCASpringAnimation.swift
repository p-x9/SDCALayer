//
//  JCASpringAnimation.swift
//
//
//  Created by p-x9 on 2024/04/09.
//  
//

import QuartzCore

open class JCASpringAnimation: JCAAnimation {
    public typealias Target = CASpringAnimation

    private enum CodingKeys: String, CodingKey {
        case mass
        case stiffness
        case damping
        case initialVelocity
    }

    open override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: PropertyMap<CASpringAnimation, JCASpringAnimation> = .init([
        .init(\.mass, \.mass),
        .init(\.stiffness, \.stiffness),
        .init(\.damping, \.damping),
        .init(\.initialVelocity, \.initialVelocity),
    ])

    public var mass: CGFloat?
    public var stiffness: CGFloat?
    public var damping: CGFloat?
    public var initialVelocity: CGFloat?

//    @available(iOS 17.0, *)
//    public var allowsOverdamping: Bool?

    public override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        mass = try container.decodeIfPresent(CGFloat.self, forKey: .mass)
        stiffness = try container.decodeIfPresent(CGFloat.self, forKey: .stiffness)
        damping = try container.decodeIfPresent(CGFloat.self, forKey: .damping)
        initialVelocity = try container.decodeIfPresent(CGFloat.self, forKey: .initialVelocity)
    }

    open override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(mass, forKey: .mass)
        try container.encodeIfPresent(stiffness, forKey: .stiffness)
        try container.encodeIfPresent(damping, forKey: .damping)
        try container.encodeIfPresent(initialVelocity, forKey: .initialVelocity)
    }

    public required convenience init(with object: Target) {
        self.init()

        applyProperties(with: object)
    }

    open override func applyProperties(to target: CAAnimation) {
        super.applyProperties(to: target)

        guard let target = target as? CASpringAnimation else { return }

        Self.propertyMap.apply(to: target, from: self)
    }

    open override func applyProperties(with target: CAAnimation) {
        super.applyProperties(with: target)

        guard let target = target as? CASpringAnimation else { return }

        Self.propertyMap.apply(to: self, from: target)
    }

    open override func convertToAnimation() -> CAAnimation? {
        let animation = CASpringAnimation()

        self.applyProperties(to: animation)
        return animation
    }
}
