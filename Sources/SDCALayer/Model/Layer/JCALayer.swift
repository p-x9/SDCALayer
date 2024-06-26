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

open class JCALayer: CALayerConvertible, Codable {
    public typealias Target = CALayer

    open class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: PropertyMap<CALayer, JCALayer> = .init([
        .init(\.bounds, \.bounds),
        .init(\.position, \.position),
        .init(\.zPosition, \.zPosition),
        .init(\.anchorPoint, \.anchorPoint),
        .init(\.anchorPointZ, \.anchorPointZ),
        .init(\.transform, \.transform),
        .init(\.frame, \.frame),
        .init(\.isHidden, \.isHidden),
        .init(\.isDoubleSided, \.isDoubleSided),
        .init(\.isGeometryFlipped, \.isGeometryFlipped),
//        .init(\.sublayers, \.sublayers), // handle manually
        .init(\.sublayerTransform, \.sublayerTransform),
//        .init(\.mask, \.mask), // handle manually
        .init(\.masksToBounds, \.masksToBounds),
//        .init(\.contents, \.contents),
        .init(\.contentsRect, \.contentsRect),
        .init(\.contentsGravity, \.contentsGravity),
        .init(\.contentsScale, \.contentsScale),
        .init(\.contentsCenter, \.contentsCenter),
        .init(\.contentsFormat, \.contentsFormat),
//        .init(\.wantsExtendedDynamicRangeContent, \.wantsExtendedDynamicRangeContent),
        .init(\.minificationFilter, \.minificationFilter),
        .init(\.magnificationFilter, \.magnificationFilter),
        .init(\.minificationFilterBias, \.minificationFilterBias),
        .init(\.isOpaque, \.isOpaque),
        .init(\.needsDisplayOnBoundsChange, \.needsDisplayOnBoundsChange),
        .init(\.drawsAsynchronously, \.drawsAsynchronously),
        .init(\.edgeAntialiasingMask, \.edgeAntialiasingMask),
        .init(\.allowsEdgeAntialiasing, \.allowsEdgeAntialiasing),
        .init(\.backgroundColor, \.backgroundColor),
        .init(\.cornerRadius, \.cornerRadius),
        .init(\.maskedCorners, \.maskedCorners),
        .init(\.cornerCurve, \.cornerCurve),
        .init(\.borderWidth, \.borderWidth),
        .init(\.borderColor, \.borderColor),
        .init(\.opacity, \.opacity),
        .init(\.allowsGroupOpacity, \.allowsGroupOpacity),
//        .init(\.compositingFilter, \.compositingFilter),
//        .init(\.filters, \.filters),
//        .init(\.backgroundFilters, \.backgroundFilters),
        .init(\.shouldRasterize, \.shouldRasterize),
        .init(\.rasterizationScale, \.rasterizationScale),
        .init(\.shadowColor, \.shadowColor),
        .init(\.shadowOpacity, \.shadowOpacity),
        .init(\.shadowOffset, \.shadowOffset),
        .init(\.shadowRadius, \.shadowRadius),
        .init(\.shadowPath, \.shadowPath),
//        .init(\.actions, \.actions),
        .init(\.name, \.name),
//        .init(\.style, \.style)
    ])

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

    public var contentsRect: CGRect?
    public var contentsGravity: JCALayerContentsGravity?
    public var contentsScale: CGFloat?
    public var contentsCenter: CGRect?
    public var contentsFormat: JCALayerContentsFormat?

//    public var wantsExtendedDynamicRangeContent: Bool?
    public var minificationFilter: JCALayerContentsFilter?
    public var magnificationFilter: JCALayerContentsFilter?
    public var minificationFilterBias: Float?

    public var isOpaque: Bool?

    public var needsDisplayOnBoundsChange: Bool?

    public var drawsAsynchronously: Bool?

    public var edgeAntialiasingMask: JCAEdgeAntialiasingMask?
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

    public var animations: [String: SDCAAnimation]?

    public init() {}

    public required convenience init(with object: CALayer) {
        self.init()

        applyProperties(with: object)
    }

    open func applyProperties(to target: CALayer) {
        Self.propertyMap.apply(to: target, from: self)

        target.mask = mask?.convertToLayer()
        sublayers?.compactMap { $0.convertToLayer() }
            .forEach {
                target.addSublayer($0)
            }

        if let animations {
            for (key, animation) in animations {
                if let animation = animation.converted() {
                    target.add(animation, forKey: key)
                }
            }
        }
    }

    open func applyProperties(with target: CALayer) {
        Self.propertyMap.apply(to: self, from: target)

        self.mask = SDCALayer(model: target.mask?.codable())
        self.sublayers = target.sublayers?.compactMap {
            SDCALayer(model: $0.codable())
        }

        if let animationKeys = target.animationKeys(),
           !animationKeys.isEmpty {
            var animations: [String: SDCAAnimation] = [:]
            for key in animationKeys {
                guard let animation = target.animation(forKey: key),
                      let model = animation.codable() else {
                    continue
                }
                animations[key] = .init(model: model)
            }
            self.animations = animations
        }
    }

    open func convertToLayer() -> CALayer? {
        let layer = CALayer()

        self.applyProperties(to: layer)

        return layer
    }
}

public final class JCALayerCornerCurve: RawIndirectlyCodableModel {
    public typealias Target = CALayerCornerCurve

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}

public final class JCACornerMask: RawIndirectlyCodableModel {
    public typealias Target = CACornerMask

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}

public final class JCALayerContentsGravity: RawIndirectlyCodableModel {
    public typealias Target = CALayerContentsGravity

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}

public final class JCALayerContentsFormat: RawIndirectlyCodableModel {
    public typealias Target = CALayerContentsFormat

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}

public final class JCALayerContentsFilter: RawIndirectlyCodableModel {
    public typealias Target = CALayerContentsFilter

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}

public final class JCAEdgeAntialiasingMask: RawIndirectlyCodableModel {
    public typealias Target = CAEdgeAntialiasingMask

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}
