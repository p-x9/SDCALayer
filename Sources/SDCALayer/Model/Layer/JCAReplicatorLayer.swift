//
//  JCAReplicatorLayer.swift
//  
//
//  Created by p-x9 on 2024/04/04.
//  
//

import Foundation
import QuartzCore
import KeyPathValue

open class JCAReplicatorLayer: JCALayer {
    public typealias Target = CAReplicatorLayer

    private enum CodingKeys: String, CodingKey {
        case instanceCount
        case preservesDepth

        case instanceDelay
        case instanceTransform
        case instanceColor

        case instanceRedOffset
        case instanceGreenOffset
        case instanceBlueOffset
        case instanceAlphaOffset
    }

    open override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: PropertyMap<CAReplicatorLayer, JCAReplicatorLayer> = .init([
        .init(\.instanceCount, \.instanceCount),
        .init(\.preservesDepth, \.preservesDepth),
        .init(\.instanceDelay, \.instanceDelay),
        .init(\.instanceTransform, \.instanceTransform),
        .init(\.instanceColor, \.instanceColor),
        .init(\.instanceRedOffset, \.instanceRedOffset),
        .init(\.instanceGreenOffset, \.instanceGreenOffset),
        .init(\.instanceBlueOffset, \.instanceBlueOffset),
        .init(\.instanceAlphaOffset, \.instanceAlphaOffset),
    ])

    public var instanceCount: Int?
    public var preservesDepth: Bool?

    public var instanceDelay: CFTimeInterval?
    public var instanceTransform: CATransform3D?
    public var instanceColor: JCGColor?

    public var instanceRedOffset: Float?
    public var instanceGreenOffset: Float?
    public var instanceBlueOffset: Float?
    public var instanceAlphaOffset: Float?

    public override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        instanceCount = try container.decodeIfPresent(Int.self, forKey: .instanceCount)
        preservesDepth = try container.decodeIfPresent(Bool.self, forKey: .preservesDepth)
        instanceDelay = try container.decodeIfPresent(CFTimeInterval.self, forKey: .instanceDelay)
        instanceTransform = try container.decodeIfPresent(CATransform3D.self, forKey: .instanceTransform)
        instanceColor = try container.decodeIfPresent(JCGColor.self, forKey: .instanceColor)
        instanceRedOffset = try container.decodeIfPresent(Float.self, forKey: .instanceRedOffset)
        instanceGreenOffset = try container.decodeIfPresent(Float.self, forKey: .instanceGreenOffset)
        instanceBlueOffset = try container.decodeIfPresent(Float.self, forKey: .instanceBlueOffset)
        instanceAlphaOffset = try container.decodeIfPresent(Float.self, forKey: .instanceAlphaOffset)
    }

    public required convenience init(with object: CALayer) {
        self.init()

        applyProperties(with: object)
    }

    open override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(instanceCount, forKey: .instanceCount)
        try container.encodeIfPresent(preservesDepth, forKey: .preservesDepth)
        try container.encodeIfPresent(instanceDelay, forKey: .instanceDelay)
        try container.encodeIfPresent(instanceTransform, forKey: .instanceTransform)
        try container.encodeIfPresent(instanceColor, forKey: .instanceColor)
        try container.encodeIfPresent(instanceRedOffset, forKey: .instanceRedOffset)
        try container.encodeIfPresent(instanceGreenOffset, forKey: .instanceGreenOffset)
        try container.encodeIfPresent(instanceBlueOffset, forKey: .instanceBlueOffset)
        try container.encodeIfPresent(instanceAlphaOffset, forKey: .instanceAlphaOffset)
    }

    open override func applyProperties(to target: CALayer) {
        super.applyProperties(to: target)

        guard let target = target as? CAReplicatorLayer else { return }

        Self.propertyMap.apply(to: target, from: self)
    }

    open override func applyProperties(with target: CALayer) {
        super.applyProperties(with: target)

        guard let target = target as? CAReplicatorLayer else { return }

        Self.propertyMap.apply(to: self, from: target)
    }

    open override func convertToLayer() -> CALayer? {
        let layer = CAReplicatorLayer()

        self.applyProperties(to: layer)

        return layer
    }
}
