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

    static private let propertyMap: PropertyMap<CALayer, JCALayer> = [
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

    static private let reversePropertyMap: PropertyMap<JCALayer, CALayer> = [
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

    public var bounds: CGRect?
    public var position: CGPoint?

    public var zPosition: CGFloat?
    public var anchorPoint: CGPoint?
    public var anchorPointZ: CGFloat?

    public var transform: CATransform3D?

    public var frame: CGRect?
    public var isHidden: Bool?

    public var isDoubleSided: Bool?
    public var isGeometryFlipped: Bool?

    public var sublayers: [SDCALayer]?

    public var sublayerTransform: CATransform3D?

    public var mask: SDCALayer?
    public var masksToBounds: Bool?

    public var isOpaque: Bool?

    public var drawsAsynchronously: Bool?

    public var allowsEdgeAntialiasing: Bool?

    public var backgroundColor: JCGColor?

    public var cornerRadius: CGFloat?
    public var maskedCorners: JCACornerMask?

    @available(iOS 13.0, *)
    public var cornerCurve: JCALayerCornerCurve?

    public var borderWidth: CGFloat?
    public var borderColor: JCGColor?

    public var opacity: Float?
    public var allowsGroupOpacity: Bool?

    public var shouldRasterize: Bool?
    public var rasterizationScale: CGFloat?

    public var shadowColor: JCGColor?
    public var shadowOpacity: Float?
    public var shadowOffset: CGSize?
    public var shadowRadius: CGFloat?
    public var shadowPath: JCGPath?

    public var name: String?

    public init() {}

    public required convenience init(with object: CALayer) {
        self.init()

        reverseApplyProperties(with: object)
    }

    public func applyProperties(to target: CALayer) {
        Self.propertyMap.apply(to: target, from: self)

        sublayers?.compactMap { $0.convertToLayer() }
            .forEach {
                target.addSublayer($0)
            }
    }

    public func reverseApplyProperties(with target: CALayer) {
        Self.reversePropertyMap.apply(to: self, from: target)

        self.mask = SDCALayer(model: target.mask?.codable())
        self.sublayers = target.sublayers?.compactMap {
            SDCALayer(model: $0.codable())
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

    public var rawValue: String?

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

    public var rawValue: UInt?

    required public init(with object: CACornerMask) {
        rawValue = object.rawValue
    }

    public func converted() -> CACornerMask? {
        guard let rawValue else { return nil }
        return .init(rawValue: rawValue)
    }
}
