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

public class JCAScrollLayer: JCALayer {
    typealias Target = CAScrollLayer

    private enum CodingKeys: String, CodingKey {
        case scrollMode
    }

    public override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    var scrollMode: JCAScrollLayerScrollMode?

    override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        scrollMode = try container.decodeIfPresent(JCAScrollLayerScrollMode.self, forKey: .scrollMode)
    }

    public required convenience init(with object: CALayer) {
        self.init()

        reverseApplyProperties(with: object)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(scrollMode, forKey: .scrollMode)
    }

    public override func applyProperties(to target: CALayer) {
        super.applyProperties(to: target)

        guard let target = target as? CAScrollLayer else { return }

        if let scrollMode = scrollMode?.converted() {
            target.scrollMode = scrollMode
        }
    }

    public override func reverseApplyProperties(with target: CALayer) {
        super.reverseApplyProperties(with: target)

        guard let target = target as? CAScrollLayer else { return }

        scrollMode = target.scrollMode.codable()
    }

    public override func convertToLayer() -> CALayer? {
        let layer = CAScrollLayer()

        self.applyProperties(to: layer)

        return layer
    }
}

public class JCAScrollLayerScrollMode: ObjectConvertiblyCodable {
    public typealias Target = CAScrollLayerScrollMode

    var rawValue: String?

    required public init(with object: CAScrollLayerScrollMode) {
        rawValue = object.rawValue
    }

    public func converted() -> CAScrollLayerScrollMode? {
        guard let rawValue else { return nil }
        return .init(rawValue: rawValue)
    }
}
