//
//  JCATextLayer.swift
//  
//
//  Created by p-x9 on 2022/11/14.
//  
//

import Foundation
import QuartzCore
import CoreText
import KeyPathValue

public class JCATextLayer: JCALayer {
    typealias Target = CATextLayer

    private enum CodingKeys: String, CodingKey {
        case string, font, fontSize, foregroundColor, isWrapped, truncationMode, alignmentMode, allowsFontSubpixelQuantization
    }

    public override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: [PartialKeyPath<JCATextLayer>: ReferenceWritableKeyPathValueApplier<CATextLayer>] = [
        \.string: .init(\.string),
         \.font: .init(\.font),
         \.fontSize: .init(\.fontSize),
         \.foregroundColor: .init(\.foregroundColor),
         \.isWrapped: .init(\.isWrapped),
         \.truncationMode: .init(\.truncationMode),
         \.alignmentMode: .init(\.alignmentMode),
         \.allowsFontSubpixelQuantization: .init(\.allowsFontSubpixelQuantization)
    ]

    static private let reversePropertyMap: [PartialKeyPath<CATextLayer>: ReferenceWritableKeyPathValueApplier<JCATextLayer>] = [
        \.string: .init(\.string),
//         \.font: .init(\.font),
         \.fontSize: .init(\.fontSize),
         \.foregroundColor: .init(\.foregroundColor),
         \.isWrapped: .init(\.isWrapped),
         \.truncationMode: .init(\.truncationMode),
         \.alignmentMode: .init(\.alignmentMode),
         \.allowsFontSubpixelQuantization: .init(\.allowsFontSubpixelQuantization)
    ]

    public var string: String?

    public var font: String?

    public var fontSize: CGFloat?

    public var foregroundColor: JCGColor?

    public var isWrapped: Bool?

    public var truncationMode: JCATextLayerTruncationMode?

    public var alignmentMode: JCATextLayerAlignmentMode?

    public var allowsFontSubpixelQuantization: Bool?

    override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)

        string = try container.decodeIfPresent(String.self, forKey: .string)

        font = try container.decodeIfPresent(String.self, forKey: .font)
        fontSize = try container.decodeIfPresent(CGFloat.self, forKey: .fontSize)

        foregroundColor = try container.decodeIfPresent(JCGColor.self, forKey: .foregroundColor)

        isWrapped = try container.decodeIfPresent(Bool.self, forKey: .isWrapped)

        truncationMode = try container.decodeIfPresent(JCATextLayerTruncationMode.self, forKey: .truncationMode)

        alignmentMode = try container.decodeIfPresent(JCATextLayerAlignmentMode.self, forKey: .alignmentMode)

        allowsFontSubpixelQuantization = try container.decodeIfPresent(Bool.self, forKey: .allowsFontSubpixelQuantization)
    }

    public required convenience init(with object: CALayer) {
        self.init()

        reverseApplyProperties(with: object)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(string, forKey: .string)

        try container.encode(font, forKey: .font)
        try container.encode(fontSize, forKey: .fontSize)

        try container.encode(foregroundColor, forKey: .foregroundColor)

        try container.encode(isWrapped, forKey: .isWrapped)

        try container.encode(truncationMode, forKey: .truncationMode)

        try container.encode(alignmentMode, forKey: .alignmentMode)

        try container.encode(allowsFontSubpixelQuantization, forKey: .allowsFontSubpixelQuantization)
    }

    public override func applyProperties(to target: CALayer) {
        super.applyProperties(to: target)

        guard let textLayer = target as? CATextLayer else { return }

        Self.propertyMap.forEach { keyPath, applier in
            var value = self[keyPath: keyPath]
            if let convertible = value as? (any ObjectConvertiblyCodable),
               let converted = convertible.converted() {
                value = converted
            }
            applier.apply(value, textLayer)
        }
    }

    public override func reverseApplyProperties(with target: CALayer) {
        super.reverseApplyProperties(with: target)

        guard let target = target as? CATextLayer else { return }

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

        if let font = target[keyPath: \.font] {
            switch CFGetTypeID(font) {
            case CFStringGetTypeID():
                self.font = font as? String
            case CTFontGetTypeID():
                self.font = CTFontCopyPostScriptName(font as! CTFont) as String
            case CGFont.typeID:
                self.font = (font as! CGFont).postScriptName as? String
            default:
                break
            }
        }
    }

    public override func convertToLayer() -> CALayer? {
        let layer = CATextLayer()

        self.applyProperties(to: layer)

        return layer
    }
}

public class JCATextLayerTruncationMode: ObjectConvertiblyCodable {
    public typealias Target = CATextLayerTruncationMode

    public var rawValue: String?

    required public init(with object: CATextLayerTruncationMode) {
        rawValue = object.rawValue
    }

    public func converted() -> CATextLayerTruncationMode? {
        guard let rawValue else { return nil }
        return .init(rawValue: rawValue)
    }
}

public class JCATextLayerAlignmentMode: ObjectConvertiblyCodable {
    public typealias Target = CATextLayerAlignmentMode

    public var rawValue: String?

    required public init(with object: CATextLayerAlignmentMode) {
        rawValue = object.rawValue
    }

    public func converted() -> CATextLayerAlignmentMode? {
        guard let rawValue else { return nil }
        return .init(rawValue: rawValue)
    }
}
