//
//  SDCALayer.swift
//  
//
//  Created by p-x9 on 2022/11/07.
//  
//

import QuartzCore

public class SDCALayer: CALayerConvertible {
    public typealias Target = CALayer

    enum CodingKeys: String, CodingKey {
        case `class`, layerModel
    }

    public var `class`: String?
    public var layerModel: (any CALayerConvertible)?

    static func layerModelClass(for className: String?) -> Codable.Type? {
        guard let className,
              let layerClass = NSClassFromString(className) as? any IndirectlyCodable.Type,
              let layerModelClass = NSClassFromString(layerClass.codableTypeName) as? any Codable.Type else {
            return nil
        }
        return layerModelClass
    }

    public static func load(from json: String) -> SDCALayer? {
        SDCALayer.value(from: json)
    }

    public var json: String? {
        self.jsonString
    }

    public init(model: (any CALayerConvertible)) {
        self.class = type(of: model).targetTypeName
        self.layerModel = model
    }

    public convenience init?(model: (any CALayerConvertible)?) {
        guard let model else { return nil }

        self.init(model: model)
    }

    public init(class: String?, model: any CALayerConvertible) {
        self.class = `class`
        self.layerModel = model
    }

    public required convenience init(with object: CALayer) {
        guard let model = object.codable() else {
            fatalError("not supported Layer type")
        }
        self.init(model: model)
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        `class` = try container.decodeIfPresent(String.self, forKey: .class)
        guard let layerClass = Self.layerModelClass(for: `class`) as? any CALayerConvertible.Type else {
            return
        }

        layerModel = try container.decodeIfPresent(layerClass, forKey: .layerModel)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(`class`, forKey: .class)

        guard let layerModel else {
            return
        }
        try container.encode(layerModel, forKey: .layerModel)
    }

    public func convertToLayer() -> Target? {
        layerModel?.convertToLayer() as? CALayer
    }
}
