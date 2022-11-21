//
//  JCAGradientLayer.swift
//  
//
//  Created by p-x9 on 2022/11/11.
//  
//

import Foundation
import QuartzCore
import KeyPathValue

public class JCAGradientLayer: JCALayer {
    public typealias Target = CAGradientLayer

    private enum CodingKeys: String, CodingKey {
        case colors, locations, startPoint, endPoint, type
    }

    public override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: PropertyMap<CAGradientLayer, JCAGradientLayer> = [
        \.colors: .init(\.colors),
         \.startPoint: .init(\.startPoint),
         \.endPoint: .init(\.endPoint),
         \.type: .init(\.type)
    ]

    static private let reversePropertyMap: PropertyMap<JCAGradientLayer, CAGradientLayer> = [
        \.colors: .init(\.colors),
         \.startPoint: .init(\.startPoint),
         \.endPoint: .init(\.endPoint),
         \.type: .init(\.type)
    ]

    public var colors: [JCGColor]?
    public var locations: [Double]?

    public var startPoint: CGPoint?
    public var endPoint: CGPoint?

    public var type: JCAGradientLayerType?

    override init() {
        super.init()
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        colors = try container.decodeIfPresent([JCGColor].self, forKey: .colors)
        locations = try container.decodeIfPresent([Double].self, forKey: .locations)

        startPoint = try container.decodeIfPresent(CGPoint.self, forKey: .startPoint)
        endPoint = try container.decodeIfPresent(CGPoint.self, forKey: .endPoint)

        type = try container.decodeIfPresent(JCAGradientLayerType.self, forKey: .type)
    }

    public required convenience init(with object: CALayer) {
        self.init()

        reverseApplyProperties(with: object)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(colors, forKey: .colors)
        try container.encode(locations, forKey: .locations)

        try container.encode(startPoint, forKey: .startPoint)
        try container.encode(endPoint, forKey: .endPoint)

        try container.encode(type, forKey: .type)
    }

    public override func applyProperties(to target: CALayer) {
        super.applyProperties(to: target)

        guard let target = target as? CAGradientLayer else { return }

        Self.propertyMap.apply(to: target, from: self)

        target.locations = locations?.map { NSNumber(floatLiteral: $0) }
    }

    public override func reverseApplyProperties(with target: CALayer) {
        super.reverseApplyProperties(with: target)

        guard let target = target as? CAGradientLayer else { return }

        Self.reversePropertyMap.apply(to: self, from: target)

        self.locations = target.locations?.map { $0.doubleValue }
    }

    public override func convertToLayer() -> CALayer? {
        let layer = CAGradientLayer()

        self.applyProperties(to: layer)

        return layer
    }
}

public class JCAGradientLayerType: ObjectConvertiblyCodable {
    public typealias Target = CAGradientLayerType

    public var rawValue: String?

    required public init(with object: CAGradientLayerType) {
        rawValue = object.rawValue
    }

    public func converted() -> CAGradientLayerType? {
        guard let rawValue else { return nil }
        return .init(rawValue: rawValue)
    }
}
