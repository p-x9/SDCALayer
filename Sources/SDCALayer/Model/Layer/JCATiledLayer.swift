//
//  JCATiledLayer.swift
//
//
//  Created by p-x9 on 2024/04/05.
//  
//

import Foundation
import QuartzCore
import KeyPathValue

open class JCATiledLayer: JCALayer {
    public typealias Target = CATiledLayer

    private enum CodingKeys: String, CodingKey {
        case levelsOfDetail
        case levelsOfDetailBias
        case tileSize
    }

    open override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: PropertyMap<CATiledLayer, JCATiledLayer> = .init([
        .init(\.levelsOfDetail, \.levelsOfDetail),
        .init(\.levelsOfDetailBias, \.levelsOfDetailBias),
        .init(\.tileSize, \.tileSize)
    ])

    public var levelsOfDetail: Int?
    public var levelsOfDetailBias: Int?
    public var tileSize: CGSize?

    public override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        levelsOfDetail = try container.decodeIfPresent(Int.self, forKey: .levelsOfDetail)
        levelsOfDetailBias = try container.decodeIfPresent(Int.self, forKey: .levelsOfDetailBias)

        tileSize = try container.decodeIfPresent(CGSize.self, forKey: .tileSize)
    }

    public required convenience init(with object: CALayer) {
        self.init()

        applyProperties(with: object)
    }

    open override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(levelsOfDetail, forKey: .levelsOfDetail)
        try container.encodeIfPresent(levelsOfDetailBias, forKey: .levelsOfDetailBias)
        try container.encodeIfPresent(tileSize, forKey: .tileSize)
    }

    open override func applyProperties(to target: CALayer) {
        super.applyProperties(to: target)

        guard let target = target as? CATiledLayer else { return }

        Self.propertyMap.apply(to: target, from: self)
    }

    open override func applyProperties(with target: CALayer) {
        super.applyProperties(with: target)

        guard let target = target as? CATiledLayer else { return }

        Self.propertyMap.apply(to: self, from: target)
    }

    open override func convertToLayer() -> CALayer? {
        let layer = CATiledLayer()

        self.applyProperties(to: layer)

        return layer
    }
}
