//
//  JCAScrollLayer.swift
//  
//
//  Created by p-x9 on 2022/11/15.
//  
//

import Foundation
import QuartzCore
import KeyPathValue

open class JCAScrollLayer: JCALayer {
    typealias Target = CAScrollLayer

    private enum CodingKeys: String, CodingKey {
        case scrollMode
    }

    open override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    public var scrollMode: JCAScrollLayerScrollMode?

    public override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        scrollMode = try container.decodeIfPresent(JCAScrollLayerScrollMode.self, forKey: .scrollMode)
    }

    public required convenience init(with object: CALayer) {
        self.init()

        applyProperties(with: object)
    }

    open override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(scrollMode, forKey: .scrollMode)
    }

    open override func applyProperties(to target: CALayer) {
        super.applyProperties(to: target)

        guard let target = target as? CAScrollLayer else { return }

        if let scrollMode = scrollMode?.converted() {
            target.scrollMode = scrollMode
        }
    }

    open override func applyProperties(with target: CALayer) {
        super.applyProperties(with: target)

        guard let target = target as? CAScrollLayer else { return }

        scrollMode = target.scrollMode.codable()
    }

    open override func convertToLayer() -> CALayer? {
        let layer = CAScrollLayer()

        self.applyProperties(to: layer)

        return layer
    }
}

public final class JCAScrollLayerScrollMode: RawIndirectlyCodableModel {
    public typealias Target = CAScrollLayerScrollMode

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}
