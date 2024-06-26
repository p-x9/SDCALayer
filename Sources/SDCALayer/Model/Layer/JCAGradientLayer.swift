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

open class JCAGradientLayer: JCALayer {
    public typealias Target = CAGradientLayer

    private enum CodingKeys: String, CodingKey {
        case colors
        case locations
        case startPoint
        case endPoint
        case type
    }

    open override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: PropertyMap<CAGradientLayer, JCAGradientLayer> = .init([
//        .init(\.colors, \.colors), // handle manually
//        .init(\.locations, \.locations), // handle manually
        .init(\.startPoint, \.startPoint),
        .init(\.endPoint, \.endPoint),
        .init(\.type, \.type)
    ])

    public var colors: [JCGColor]?
    public var locations: [Double]?

    public var startPoint: CGPoint?
    public var endPoint: CGPoint?

    public var type: JCAGradientLayerType?

    public override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
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

        applyProperties(with: object)
    }

    open override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(colors, forKey: .colors)
        try container.encodeIfPresent(locations, forKey: .locations)

        try container.encodeIfPresent(startPoint, forKey: .startPoint)
        try container.encodeIfPresent(endPoint, forKey: .endPoint)

        try container.encodeIfPresent(type, forKey: .type)
    }

    open override func applyProperties(to target: CALayer) {
        super.applyProperties(to: target)

        guard let target = target as? CAGradientLayer else { return }

        Self.propertyMap.apply(to: target, from: self)

        target.colors = colors?
            .compactMap {
                $0.converted()
            }
        target.locations = locations?.map { NSNumber(floatLiteral: $0) }
    }

    open override func applyProperties(with target: CALayer) {
        super.applyProperties(with: target)

        guard let target = target as? CAGradientLayer else { return }

        Self.propertyMap.apply(to: self, from: target)

        self.colors = target.colors?
            .filter {
                CFGetTypeID($0 as AnyObject) == CGColor.typeID
            }
            .map {
                $0 as! CGColor
            }
            .compactMap {
                $0.codable()
            }
        self.locations = target.locations?.map { $0.doubleValue }
    }

    open override func convertToLayer() -> CALayer? {
        let layer = CAGradientLayer()

        self.applyProperties(to: layer)

        return layer
    }
}

public final class JCAGradientLayerType: RawIndirectlyCodableModel {
    public typealias Target = CAGradientLayerType

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}
