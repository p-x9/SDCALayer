//
//  SDCAAnimation.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore
import IndirectlyCodable

public class SDCAAnimation: CAAnimationConvertible {
    public typealias Target = CAAnimation

    enum CodingKeys: String, CodingKey {
        case `class`, animationModel
    }

    public var `class`: String?
    public var animationModel: (any CAAnimationConvertible)?

    static func animationModelClass(for className: String?) -> Codable.Type? {
        guard let className,
              let layerClass = NSClassFromString(className) as? any IndirectlyCodable.Type,
              let layerModelClass = NSClassFromString(layerClass.codableTypeName) as? any Codable.Type else {
            return nil
        }
        return layerModelClass
    }

    public static func load(fromJSON json: String) -> SDCAAnimation? {
        SDCAAnimation.value(fromJSON: json)
    }

    public static func load(fromYAML yaml: String) -> SDCAAnimation? {
        SDCAAnimation.value(fromYAML: yaml)
    }

    public var json: String? {
        self.jsonString
    }

    public var yaml: String? {
        self.yamlString
    }

    public init(model: (any CAAnimationConvertible)) {
        self.class = type(of: model).targetTypeName
        self.animationModel = model
    }

    public convenience init?(model: (any CAAnimationConvertible)?) {
        guard let model else { return nil }

        self.init(model: model)
    }

    public init(class: String?, model: any CAAnimationConvertible) {
        self.class = `class`
        self.animationModel = model
    }

    public required convenience init(with object: CAAnimation) {
        guard let model = object.codable() else {
            fatalError("not supported Layer type")
        }
        self.init(model: model)
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        `class` = try container.decodeIfPresent(String.self, forKey: .class)
        guard let layerClass = Self.animationModelClass(for: `class`) as? any CAAnimationConvertible.Type else {
            return
        }

        animationModel = try container.decodeIfPresent(layerClass, forKey: .animationModel)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(`class`, forKey: .class)

        guard let animationModel else {
            return
        }
        try container.encode(animationModel, forKey: .animationModel)
    }

    public func convertToAnimation() -> Target? {
        animationModel?.converted() as? CAAnimation
    }
}
