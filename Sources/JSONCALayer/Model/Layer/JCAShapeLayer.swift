//
//  JCAShapeLayer.swift
//  
//
//  Created by p-x9 on 2022/11/06.
//  
//

import Foundation
import QuartzCore

class JCAShapeLayer: JCALayer {
    typealias Target = CAShapeLayer

    private enum CodingKeys: String, CodingKey {
        case path, fillColor, fillRule, strokeColor, strokeStart, strokeEnd, lineWidth, miterLimit, lineCap, lineJoin, lineDashPhase, lineDashPattern
    }

    static private let propertyMap: [PartialKeyPath<JCAShapeLayer>: ReferenceWritableKeyPathValueApplier<CAShapeLayer>] = [
        \.path: .init(\.path),
         \.fillColor: .init(\.fillColor),
         \.fillRule: .init(\.fillRule),
         \.strokeColor: .init(\.strokeColor),
         \.strokeStart: .init(\.strokeStart),
         \.strokeEnd: .init(\.strokeEnd),
         \.lineWidth: .init(\.lineWidth),
         \.miterLimit: .init(\.miterLimit),
         \.lineCap: .init(\.lineCap),
         \.lineJoin: .init(\.lineJoin),
         \.lineDashPhase: .init(\.lineDashPhase)
    ]

    var path: JCGPath?

    var fillColor: JCGColor?

    var fillRule: JCAShapeLayerFillRule?

    var strokeColor: JCGColor?

    var strokeStart: CGFloat?
    var strokeEnd: CGFloat?

    var lineWidth: CGFloat?
    var miterLimit: CGFloat?

    var lineCap: JCAShapeLayerLineCap?
    var lineJoin: JCAShapeLayerLineJoin?

    var lineDashPhase: CGFloat?

    var lineDashPattern: [Double]?

    required init(from decoder: Decoder) throws {
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

    override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(path, forKey: .path)
        try container.encode(fillColor, forKey: .fillColor)

        try container.encode(fillRule, forKey: .fillRule)

        try container.encode(strokeColor, forKey: .strokeColor)

        try container.encode(strokeStart, forKey: .strokeStart)
        try container.encode(strokeEnd, forKey: .strokeEnd)

        try container.encode(lineWidth, forKey: .lineWidth)
        try container.encode(miterLimit, forKey: .miterLimit)

        try container.encode(lineCap, forKey: .lineCap)
        try container.encode(lineJoin, forKey: .lineJoin)

        try container.encode(lineDashPhase, forKey: .lineDashPhase)

        try container.encode(lineDashPattern, forKey: .lineDashPattern)
    }

    override func applyProperties(to layer: CALayer) {
        super.applyProperties(to: layer)

        guard let shapeLayer = layer as? CAShapeLayer else { return }

        Self.propertyMap.forEach { keyPath, applier in
            var value = self[keyPath: keyPath]
            if let convertible = value as? (any ObjectConvertiblyCodable),
               let converted = convertible.converted() {
                value = converted
            }
            applier.apply(value, shapeLayer)
        }

        shapeLayer.lineDashPattern = lineDashPattern?.map { NSNumber(floatLiteral: $0) }
    }

    override func convertToLayer() -> CALayer? {
        let layer = CAShapeLayer()

        self.applyProperties(to: layer)

        return layer
    }
}

class JCAShapeLayerFillRule: ObjectConvertiblyCodable {
    typealias Target = CAShapeLayerFillRule

    var rawValue: String?

    func converted() -> CAShapeLayerFillRule? {
        guard let rawValue else { return nil }
        return .init(rawValue: rawValue)
    }
}

class JCAShapeLayerLineCap: ObjectConvertiblyCodable {
    typealias Target = CAShapeLayerLineCap

    var rawValue: String?

    func converted() -> CAShapeLayerLineCap? {
        guard let rawValue else { return nil }
        return .init(rawValue: rawValue)
    }
}

class JCAShapeLayerLineJoin: ObjectConvertiblyCodable {
    typealias Target = CAShapeLayerLineJoin

    var rawValue: String?

    func converted() -> CAShapeLayerLineJoin? {
        guard let rawValue else { return nil }
        return .init(rawValue: rawValue)
    }
}