//
//  JCAMediaTimingFunction.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore
import IndirectlyCodable

public enum JCAMediaTimingFunction: IndirectlyCodableModel, Codable {
    public typealias Target = CAMediaTimingFunction

    case linear
    case easeIn
    case easeOut
    case easeInEaseOut
    case `default`
    case other(c1: CGPoint, c2: CGPoint)

    public init(with target: Target) {
        if let name = target.name {
            switch name {
            case .linear: self = .linear
            case .easeIn: self = .easeIn
            case .easeOut: self = .easeOut
            case .easeInEaseOut: self = .easeInEaseOut
            case .default: self = .default
            default:
                break
            }
        }
        let points = target.controlPoints
        self = .other(c1: points[0], c2: points[1])
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let string = try? container.decode(String.self) {
            switch string {
            case "linear": self = .linear
            case "easeIn": self = .easeIn
            case "easeOut": self = .easeOut
            case "easeInEaseOut": self = .easeInEaseOut
            case "default": self = .default
            default: throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid function name: \(string)"
            )
            }
        }
        let points = try container.decode([CGPoint].self)
        self = .other(c1: points[0], c2: points[1])
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .linear:
            try container.encode("linear")
        case .easeIn:
            try container.encode("easeIn")
        case .easeOut:
            try container.encode("easeOut")
        case .easeInEaseOut:
            try container.encode("easeInEaseOut")
        case .default:
            try container.encode("default")
        case let .other(c1: c1, c2: c2):
            try container.encode([
                c1, c2
            ])
        }
    }

    public func converted() -> CAMediaTimingFunction? {
        switch self {
        case .linear: return .init(name: .linear)
        case .easeIn: return .init(name: .easeIn)
        case .easeOut: return .init(name: .easeOut)
        case .easeInEaseOut: return .init(name: .easeInEaseOut)
        case .default: return .init(name: .default)
        case .other(let c1, let c2):
            return .init(controlPoints: Float(c1.x), Float(c1.y), Float(c2.x), Float(c2.y))
        }
    }
}
