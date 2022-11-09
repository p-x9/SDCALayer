//
//  JSONCALayer.swift
//  
//
//  Created by p-x9 on 2022/11/07.
//  
//

import QuartzCore

public class JSONCALayer: CALayerConvertible {
    public typealias Target = CALayer

    enum CodingKeys: String, CodingKey {
        case `class`, layerModel
    }

    var `class`: String?
    public var layerModel: (any CALayerConvertible)?

    static private var prefix: String {
        NSStringFromClass(JSONCALayer.self).components(separatedBy: ".")[0]
    }

    static func getLayerClass(from className: String?) -> Codable.Type? {
        guard let className,
              let layerClass = NSClassFromString(Self.prefix + ".J" + className) as? any CALayerConvertible.Type else {
            return nil
        }
        return layerClass
    }

    public static func load(from json: String) -> JSONCALayer? {
        JSONCALayer.value(from: json)
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        `class` = try container.decodeIfPresent(String.self, forKey: .class)
        guard let layerClass = Self.getLayerClass(from: `class`) as? any CALayerConvertible.Type else {
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
