//
//  JCAShapeLayer.swift
//  
//
//  Created by p-x9 on 2022/11/06.
//  
//

import Foundation
import QuartzCore
import KeyPathValue

open class JCAShapeLayer: JCALayer {
    typealias Target = CAShapeLayer

    private enum CodingKeys: String, CodingKey {
        case path, fillColor, fillRule, strokeColor, strokeStart, strokeEnd, lineWidth, miterLimit, lineCap, lineJoin, lineDashPhase, lineDashPattern
    }

    open override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: PropertyMap<CAShapeLayer, JCAShapeLayer> = .init([
        .init(\.path, \.path),
        .init(\.fillColor, \.fillColor),
        .init(\.fillRule, \.fillRule),
        .init(\.strokeColor, \.strokeColor),
        .init(\.strokeStart, \.strokeStart),
        .init(\.strokeEnd, \.strokeEnd),
        .init(\.lineWidth, \.lineWidth),
        .init(\.miterLimit, \.miterLimit),
        .init(\.lineCap, \.lineCap),
        .init(\.lineJoin, \.lineJoin),
        .init(\.lineDashPhase, \.lineDashPhase),
//        .init(\.lineDashPattern, \.lineDashPattern)
    ])

    public var path: JCGPath?

    public var fillColor: JCGColor?

    public var fillRule: JCAShapeLayerFillRule?

    public var strokeColor: JCGColor?

    public var strokeStart: CGFloat?
    public var strokeEnd: CGFloat?

    public var lineWidth: CGFloat?
    public var miterLimit: CGFloat?

    public var lineCap: JCAShapeLayerLineCap?
    public var lineJoin: JCAShapeLayerLineJoin?

    public var lineDashPhase: CGFloat?

    public var lineDashPattern: [Double]?

    public override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        path = try container.decodeIfPresent(JCGPath.self, forKey: .path)
        fillColor = try container.decodeIfPresent(JCGColor.self, forKey: .fillColor)

        fillRule = try container.decodeIfPresent(JCAShapeLayerFillRule.self, forKey: .fillRule)

        strokeColor = try container.decodeIfPresent(JCGColor.self, forKey: .strokeColor)

        strokeStart = try container.decodeIfPresent(CGFloat.self, forKey: .strokeStart)
        strokeEnd = try container.decodeIfPresent(CGFloat.self, forKey: .strokeEnd)

        lineWidth = try container.decodeIfPresent(CGFloat.self, forKey: .lineWidth)
        miterLimit = try container.decodeIfPresent(CGFloat.self, forKey: .miterLimit)

        lineCap = try container.decodeIfPresent(JCAShapeLayerLineCap.self, forKey: .lineCap)
        lineJoin = try container.decodeIfPresent(JCAShapeLayerLineJoin.self, forKey: .lineJoin)

        lineDashPhase = try container.decodeIfPresent(CGFloat.self, forKey: .lineDashPhase)

        lineDashPattern = try container.decodeIfPresent([Double].self, forKey: .lineDashPattern)
    }

    public required convenience init(with object: CALayer) {
        self.init()

        applyProperties(with: object)
    }

    open override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(fillColor, forKey: .fillColor)

        try container.encodeIfPresent(fillRule, forKey: .fillRule)

        try container.encodeIfPresent(strokeColor, forKey: .strokeColor)

        try container.encodeIfPresent(strokeStart, forKey: .strokeStart)
        try container.encodeIfPresent(strokeEnd, forKey: .strokeEnd)

        try container.encodeIfPresent(lineWidth, forKey: .lineWidth)
        try container.encodeIfPresent(miterLimit, forKey: .miterLimit)

        try container.encodeIfPresent(lineCap, forKey: .lineCap)
        try container.encodeIfPresent(lineJoin, forKey: .lineJoin)

        try container.encodeIfPresent(lineDashPhase, forKey: .lineDashPhase)

        try container.encodeIfPresent(lineDashPattern, forKey: .lineDashPattern)
    }

    open override func applyProperties(to target: CALayer) {
        super.applyProperties(to: target)

        guard let target = target as? CAShapeLayer else { return }

        Self.propertyMap.apply(to: target, from: self)

        target.lineDashPattern = lineDashPattern?.map { NSNumber(floatLiteral: $0) }
    }

    open override func applyProperties(with target: CALayer) {
        super.applyProperties(with: target)

        guard let target = target as? CAShapeLayer else { return }

        Self.propertyMap.apply(to: self, from: target)

        self.lineDashPattern = target.lineDashPattern?.map { $0.doubleValue }
    }

    open override func convertToLayer() -> CALayer? {
        let layer = CAShapeLayer()

        self.applyProperties(to: layer)

        return layer
    }
}

public final class JCAShapeLayerFillRule: RawIndirectlyCodableModel {
    public typealias Target = CAShapeLayerFillRule

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}

public final class JCAShapeLayerLineCap: RawIndirectlyCodableModel {
    public typealias Target = CAShapeLayerLineCap

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}

public final class JCAShapeLayerLineJoin: RawIndirectlyCodableModel {
    public typealias Target = CAShapeLayerLineJoin

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}
