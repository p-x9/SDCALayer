//
//  JCALayer.swift
//  
//
//  Created by p-x9 on 2022/11/06.
//  
//

import Foundation
import QuartzCore

class JCALayer: CALayerConvertible, Codable {
    typealias Target = CALayer

    static private let propertyMap: [PartialKeyPath<JCALayer>: ReferenceWritableKeyPathValueApplier<CALayer>] = [
        \.bounds: .init(\.bounds),
         \.position: .init(\.position),
         \.zPosition: .init(\.zPosition),
         \.anchorPoint: .init(\.anchorPoint),
         \.anchorPointZ: .init(\.anchorPointZ),
         \.frame: .init(\.frame),
         \.isHidden: .init(\.isHidden),
         \.mask: .init(\.mask),
         \.masksToBounds: .init(\.masksToBounds),
         \.isOpaque: .init(\.isOpaque),
         \.backgroundColor: .init(\.backgroundColor),
         \.cornerRadius: .init(\.cornerRadius),
         \.borderWidth: .init(\.borderWidth),
         \.borderColor: .init(\.borderColor),
         \.opacity: .init(\.opacity),
         \.shadowColor: .init(\.shadowColor),
         \.shadowOpacity: .init(\.shadowOpacity),
         \.shadowOffset: .init(\.shadowOffset),
         \.shadowRadius: .init(\.shadowRadius)
    ]

    var bounds: CGRect?
    var position: CGPoint?

    var zPosition: CGFloat?
    var anchorPoint: CGPoint?
    var anchorPointZ: CGFloat?

    var frame: CGRect?
    var isHidden: Bool?

    var sublayers: [JSONCALayer]?

    var mask: JSONCALayer?
    var masksToBounds: Bool?

    var isOpaque: Bool?

    var backgroundColor: JCGColor?

    var cornerRadius: CGFloat?

    var borderWidth: CGFloat?
    var borderColor: JCGColor?

    var opacity: Float?

    var shadowColor: JCGColor?
    var shadowOpacity: Float?
    var shadowOffset: CGSize?
    var shadowRadius: CGFloat?

    init() {}

    func applyProperties(to layer: CALayer) {
        Self.propertyMap.forEach { keyPath, applier in
            var value = self[keyPath: keyPath]
            if let convertible = value as? (any ObjectConvertiblyCodable),
               let converted = convertible.converted() {
                value = converted
            }
            applier.apply(value, layer)
        }

        sublayers?.compactMap { $0.convertToLayer() }
            .forEach {
                layer.addSublayer($0)
            }
    }

    func convertToLayer() -> CALayer? {
        let layer = CALayer()

        self.applyProperties(to: layer)

        return layer
    }
}
