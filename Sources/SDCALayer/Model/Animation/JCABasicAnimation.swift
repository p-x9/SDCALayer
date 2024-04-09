//
//  JCABasicAnimation.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore

open class JCABasicAnimation: JCAPropertyAnimation {
    public typealias Target = CABasicAnimation

    private enum CodingKeys: String, CodingKey {
        case fromValue
        case toValue
        case byValue
    }

    open override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    public var fromValue: JCAAnimationAny?
    public var toValue: JCAAnimationAny?
    public var byValue: JCAAnimationAny?

    public override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        fromValue = try container.decodeIfPresent(JCAAnimationAny.self, forKey: .fromValue)
        toValue = try container.decodeIfPresent(JCAAnimationAny.self, forKey: .toValue)
        byValue = try container.decodeIfPresent(JCAAnimationAny.self, forKey: .byValue)
    }

    open override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(fromValue, forKey: .fromValue)
        try container.encodeIfPresent(toValue, forKey: .toValue)
        try container.encodeIfPresent(byValue, forKey: .byValue)
    }

    public required convenience init(with object: Target) {
        self.init()

        applyProperties(with: object)
    }

    open override func applyProperties(to target: CAAnimation) {
        super.applyProperties(to: target)

        guard let target = target as? CABasicAnimation else { return }
        target.fromValue = fromValue?.value
        target.toValue = toValue?.value
        target.byValue = byValue?.value
    }

    open override func applyProperties(with target: CAAnimation) {
        super.applyProperties(with: target)

        guard let target = target as? CABasicAnimation else { return }
        fromValue = .init(target.fromValue)
        toValue = .init(target.toValue)
        byValue = .init(target.byValue)
    }

    open override func convertToAnimation() -> CAAnimation? {
        let animation = CABasicAnimation()

        self.applyProperties(to: animation)
        return animation
    }
}
