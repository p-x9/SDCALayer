//
//  JCAAnimationGroup.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore

open class JCAAnimationGroup: JCAAnimation {
    public typealias Target = CAAnimationGroup

    private enum CodingKeys: String, CodingKey {
        case animations
    }

    open override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    public var animations: [SDCAAnimation]?

    public override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        animations = try container.decodeIfPresent([SDCAAnimation].self, forKey: .animations)
    }

    open override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(animations, forKey: .animations)
    }

    public required convenience init(with object: Target) {
        self.init()

        applyProperties(with: object)
    }

    open override func applyProperties(to target: CAAnimation) {
        super.applyProperties(to: target)

        guard let target = target as? CAAnimationGroup else { return }
        target.animations = animations?.compactMap {
            $0.converted()
        }
    }

    open override func applyProperties(with target: CAAnimation) {
        super.applyProperties(with: target)

        guard let target = target as? CAAnimationGroup else { return }
        animations = target.animations?.compactMap {
            .init(model: $0.codable())
        }
    }

    open override func convertToAnimation() -> CAAnimation? {
        let animation = CAAnimationGroup()

        self.applyProperties(to: animation)
        return animation
    }
}
