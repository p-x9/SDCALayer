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

open class JCATextLayer: JCALayer {
    typealias Target = CATextLayer

    private enum CodingKeys: String, CodingKey {
        case string, font, fontSize, foregroundColor, isWrapped, truncationMode, alignmentMode, allowsFontSubpixelQuantization
    }

    open override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: PropertyMap<CATextLayer, JCATextLayer> = .init([
        .init(\.string, \.string),
        .init(\.font, \.font),
        .init(\.fontSize, \.fontSize),
        .init(\.foregroundColor, \.foregroundColor),
        .init(\.isWrapped, \.isWrapped),
        .init(\.truncationMode, \.truncationMode),
        .init(\.alignmentMode, \.alignmentMode),
        .init(\.allowsFontSubpixelQuantization, \.allowsFontSubpixelQuantization)
    ])

    public var string: String?

    public var font: String?

    public var fontSize: CGFloat?

    public var foregroundColor: JCGColor?

    public var isWrapped: Bool?

    public var truncationMode: JCATextLayerTruncationMode?

    public var alignmentMode: JCATextLayerAlignmentMode?

    public var allowsFontSubpixelQuantization: Bool?

    public override init() {
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

        applyProperties(with: object)
    }

    open override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(string, forKey: .string)

        try container.encodeIfPresent(font, forKey: .font)
        try container.encodeIfPresent(fontSize, forKey: .fontSize)

        try container.encodeIfPresent(foregroundColor, forKey: .foregroundColor)

        try container.encodeIfPresent(isWrapped, forKey: .isWrapped)

        try container.encodeIfPresent(truncationMode, forKey: .truncationMode)

        try container.encodeIfPresent(alignmentMode, forKey: .alignmentMode)

        try container.encodeIfPresent(allowsFontSubpixelQuantization, forKey: .allowsFontSubpixelQuantization)
    }

    open override func applyProperties(to target: CALayer) {
        super.applyProperties(to: target)

        guard let target = target as? CATextLayer else { return }

        Self.propertyMap.apply(to: target, from: self)
    }

    open override func applyProperties(with target: CALayer) {
        super.applyProperties(with: target)

        guard let target = target as? CATextLayer else { return }

        Self.propertyMap.apply(to: self, from: target)

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

    open override func convertToLayer() -> CALayer? {
        let layer = CATextLayer()

        self.applyProperties(to: layer)

        return layer
    }
}

public class JCATextLayerTruncationMode: IndirectlyCodableModel {
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

public class JCATextLayerAlignmentMode: IndirectlyCodableModel {
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
