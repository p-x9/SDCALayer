//
//  JCALayer.swift
//  
//
//  Created by p-x9 on 2022/11/06.
//  
//

import Foundation
import QuartzCore
import KeyPathValue

public class JCALayer: CALayerConvertible, Codable {
    public typealias Target = CALayer

    open class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: [PartialKeyPath<JCALayer>: ReferenceWritableKeyPathValueApplier<CALayer>] = [
        \.bounds: .init(\.bounds),
         \.position: .init(\.position),
         \.zPosition: .init(\.zPosition),
         \.anchorPoint: .init(\.anchorPoint),
         \.anchorPointZ: .init(\.anchorPointZ),
         \.transform: .init(\.transform),
         \.frame: .init(\.frame),
         \.isHidden: .init(\.isHidden),
         \.isDoubleSided: .init(\.isDoubleSided),
         \.isGeometryFlipped: .init(\.isGeometryFlipped),
         \.sublayerTransform: .init(\.sublayerTransform),
         \.mask: .init(\.mask),
         \.masksToBounds: .init(\.masksToBounds),
         \.isOpaque: .init(\.isOpaque),
         \.drawsAsynchronously: .init(\.drawsAsynchronously),
         \.allowsEdgeAntialiasing: .init(\.allowsEdgeAntialiasing),
         \.backgroundColor: .init(\.backgroundColor),
         \.cornerRadius: .init(\.cornerRadius),
         \.maskedCorners: .init(\.maskedCorners),
         \.cornerCurve: .init(\.cornerCurve),
         \.borderWidth: .init(\.borderWidth),
         \.borderColor: .init(\.borderColor),
         \.opacity: .init(\.opacity),
         \.allowsGroupOpacity: .init(\.allowsGroupOpacity),
         \.shouldRasterize: .init(\.shouldRasterize),
         \.rasterizationScale: .init(\.rasterizationScale),
         \.shadowColor: .init(\.shadowColor),
         \.shadowOpacity: .init(\.shadowOpacity),
         \.shadowOffset: .init(\.shadowOffset),
         \.shadowRadius: .init(\.shadowRadius),
         \.shadowPath: .init(\.shadowPath),
         \.name: .init(\.name)
    ]

    static private let reversePropertyMap: [PartialKeyPath<CALayer>: ReferenceWritableKeyPathValueApplier<JCALayer>] = [
        \.bounds: .init(\.bounds),
         \.position: .init(\.position),
         \.zPosition: .init(\.zPosition),
         \.anchorPoint: .init(\.anchorPoint),
         \.anchorPointZ: .init(\.anchorPointZ),
         \.transform: .init(\.transform),
         \.frame: .init(\.frame),
         \.isHidden: .init(\.isHidden),
         \.isDoubleSided: .init(\.isDoubleSided),
         \.isGeometryFlipped: .init(\.isGeometryFlipped),
         \.sublayerTransform: .init(\.sublayerTransform),
         \.mask: .init(\.mask),
         \.masksToBounds: .init(\.masksToBounds),
         \.isOpaque: .init(\.isOpaque),
         \.drawsAsynchronously: .init(\.drawsAsynchronously),
         \.allowsEdgeAntialiasing: .init(\.allowsEdgeAntialiasing),
         \.backgroundColor: .init(\.backgroundColor),
         \.cornerRadius: .init(\.cornerRadius),
         \.maskedCorners: .init(\.maskedCorners),
         \.cornerCurve: .init(\.cornerCurve),
         \.borderWidth: .init(\.borderWidth),
         \.borderColor: .init(\.borderColor),
         \.opacity: .init(\.opacity),
         \.allowsGroupOpacity: .init(\.allowsGroupOpacity),
         \.shouldRasterize: .init(\.shouldRasterize),
         \.rasterizationScale: .init(\.rasterizationScale),
         \.shadowColor: .init(\.shadowColor),
         \.shadowOpacity: .init(\.shadowOpacity),
         \.shadowOffset: .init(\.shadowOffset),
         \.shadowRadius: .init(\.shadowRadius),
         \.shadowPath: .init(\.shadowPath),
         \.name: .init(\.name),
         \.sublayers: .init(\.sublayers)
    ]

    var bounds: CGRect?
    var position: CGPoint?

    var zPosition: CGFloat?
    var anchorPoint: CGPoint?
    var anchorPointZ: CGFloat?

    var transform: CATransform3D?

    var frame: CGRect?
    var isHidden: Bool?

    var isDoubleSided: Bool?
    var isGeometryFlipped: Bool?

    var sublayers: [JSONCALayer]?

    var sublayerTransform: CATransform3D?

    var mask: JSONCALayer?
    var masksToBounds: Bool?

    var isOpaque: Bool?

    var drawsAsynchronously: Bool?

    var allowsEdgeAntialiasing: Bool?

    var backgroundColor: JCGColor?

    var cornerRadius: CGFloat?
    var maskedCorners: JCACornerMask?

    @available(iOS 13.0, *)
    open var cornerCurve: JCALayerCornerCurve?

    var borderWidth: CGFloat?
    var borderColor: JCGColor?

    var opacity: Float?
    var allowsGroupOpacity: Bool?

    var shouldRasterize: Bool?
    var rasterizationScale: CGFloat?

    var shadowColor: JCGColor?
    var shadowOpacity: Float?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?
    var shadowPath: JCGPath?

    var name: String?

    public init() {}

    public required convenience init(with object: CALayer) {
        self.init()

        reverseApplyProperties(with: object)
    }

    public func applyProperties(to target: CALayer) {
        Self.propertyMap.forEach { keyPath, applier in
            var value = self[keyPath: keyPath]
            if let convertible = value as? (any ObjectConvertiblyCodable),
               let converted = convertible.converted() {
                value = converted
            }
            applier.apply(value, target)
        }

        sublayers?.compactMap { $0.convertToLayer() }
            .forEach {
                target.addSublayer($0)
            }
    }

    public func reverseApplyProperties(with target: CALayer) {
        Self.reversePropertyMap.forEach { keyPath, applier in
            var value = target[keyPath: keyPath]
            switch value {
            case let v as (any IndirectlyCodable):
                guard let codable = v.codable() else { return }
                value = codable
            default:
                break
            }
            applier.apply(value, self)
        }

        self.mask = JSONCALayer(model: target.mask?.codable())
        self.sublayers = target.sublayers?.compactMap {
            JSONCALayer(model: $0.codable())
        }
    }

    public func convertToLayer() -> CALayer? {
        let layer = CALayer()

        self.applyProperties(to: layer)

        return layer
    }
}

public class JCALayerCornerCurve: ObjectConvertiblyCodable {
    public typealias Target = CALayerCornerCurve

    var rawValue: String?

    required public init(with object: CALayerCornerCurve) {
        rawValue = object.rawValue
    }

    public func converted() -> CALayerCornerCurve? {
        guard let rawValue else { return nil }
        return .init(rawValue: rawValue)
    }
}


public class JCACornerMask: ObjectConvertiblyCodable {
    public typealias Target = CACornerMask

    var rawValue: UInt?

    required public init(with object: CACornerMask) {
        rawValue = object.rawValue
    }

    public func converted() -> CACornerMask? {
        guard let rawValue else { return nil }
        return .init(rawValue: rawValue)
    }
}
