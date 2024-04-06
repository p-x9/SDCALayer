//
//  JCAPropertyAnimation.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore

open class JCAPropertyAnimation: JCAAnimation {
    public typealias Target = CAPropertyAnimation

    private enum CodingKeys: String, CodingKey {
        case keyPath
        case isAdditive
        case isCumulative
        case valueFunction
    }

    open override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: PropertyMap<CAPropertyAnimation, JCAPropertyAnimation> = .init([
        .init(\.keyPath, \.keyPath),
        .init(\.isAdditive, \.isAdditive),
        .init(\.isCumulative, \.isCumulative),
        .init(\.valueFunction, \.valueFunction),
    ])

    public var keyPath: String?
    public var isAdditive: Bool?
    public var isCumulative: Bool?
    public var valueFunction: JCAValueFunction?

    public override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        keyPath = try container.decodeIfPresent(String.self, forKey: .keyPath)
        isAdditive = try container.decodeIfPresent(Bool.self, forKey: .isAdditive)
        isCumulative = try container.decodeIfPresent(Bool.self, forKey: .isCumulative)
        valueFunction = try container.decodeIfPresent(JCAValueFunction.self, forKey: .valueFunction)
    }

    open override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(keyPath, forKey: .keyPath)
        try container.encodeIfPresent(isAdditive, forKey: .isAdditive)
        try container.encodeIfPresent(isCumulative, forKey: .isCumulative)
        try container.encodeIfPresent(valueFunction, forKey: .valueFunction)
    }

    public required convenience init(with object: Target) {
        self.init()

        applyProperties(with: object)
    }

    open override func applyProperties(to target: CAAnimation) {
        super.applyProperties(to: target)

        guard let target = target as? CAPropertyAnimation else { return }

        Self.propertyMap.apply(to: target, from: self)
    }

    open override func applyProperties(with target: CAAnimation) {
        super.applyProperties(with: target)

        guard let target = target as? CAPropertyAnimation else { return }

        Self.propertyMap.apply(to: self, from: target)
    }

    open override func converted() -> CAAnimation? {
        let animation = CAPropertyAnimation()

        self.applyProperties(to: animation)
        return animation
    }
}
