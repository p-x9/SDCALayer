//
//  JCAAnimationAny.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore
import IndirectlyCodable

public struct JCAAnimationAny: Codable {
    public enum ValueType: String, Codable {
        case int
        case float
        case point
        case rect
        case color
    }
    var type: ValueType
    var value: Any

    public enum CodingKeys: String, CodingKey {
        case type
        case value
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(ValueType.self, forKey: .type)
        var value: Any
        switch type {
        case .int:
            value = try container.decode(Int.self, forKey: .value)
        case .float:
            value = try container.decode(Double.self, forKey: .value)
        case .point:
            value = try container.decode(CGPoint.self, forKey: .value)
        case .rect:
            value = try container.decode(CGRect.self, forKey: .value)
        case .color:
            value = try container.decode(JCGColor.self, forKey: .value)
        }
        if let v = value as? any IndirectlyCodableModel,
           let converted = v.converted() {
            value = converted
        }
        self.value = value
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)

        switch value {
        case let v as any FixedWidthInteger:
            try container.encode(Int(v), forKey: .value)
        case let v as any BinaryFloatingPoint:
            try container.encode(Double(v), forKey: .value)
        case let v as CGPoint:
            try container.encode(v, forKey: .value)
        case let v as CGRect:
            try container.encode(v, forKey: .value)
        case let v as CGColor where CFGetTypeID(v) == CGColor.typeID:
            try container.encodeIfPresent(v.codable(), forKey: .value)
        default:
            throw EncodingError.invalidValue(
                value,
                .init(codingPath: [CodingKeys.value], debugDescription: "Unsupported Value Type")
            )
        }
    }
}

extension JCAAnimationAny {
    init?(_ value: Any?) {
        guard var value = value else { return nil }
        value = value as Any
        if let v = value as? any IndirectlyCodable,
           let codable = v.codable() {
            value = codable
        }

        switch value {
        case let v as any FixedWidthInteger:
            self.value = v
            self.type = .int

        case let v as any BinaryFloatingPoint:
            self.value = v
            self.type = .float

        case let v as CGPoint:
            self.value = v
            self.type = .point

        case let v as CGRect:
            self.value = v
            self.type = .rect

        case let v as NSInteger:
            self.value = Int(v)
            self.type = .int

        case let v as NSNumber:
            self.value = v.doubleValue
            self.type = .float

        case let v as CGColor:
            self.value = v
            self.type = .color
        default:
            return nil
        }
    }
}
