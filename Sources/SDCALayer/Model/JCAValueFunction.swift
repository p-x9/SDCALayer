//
//  JCAValueFunction.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore
import IndirectlyCodable

public enum JCAValueFunction: String, IndirectlyCodableModel, Codable {
    public typealias Target = CAValueFunction

    case rotateX
    case rotateY
    case rotateZ

    case scale
    case scaleX
    case scaleY
    case scaleZ

    case translate
    case translateX
    case translateY
    case translateZ

    public init(with target: CAValueFunction) {
        switch target.name {
        case .rotateX: self = .rotateX
        case .rotateY: self = .rotateY
        case .rotateZ: self = .rotateZ
        case .scale: self = .scale
        case .scaleX: self = .scaleX
        case .scaleY: self = .scaleY
        case .scaleZ: self = .scaleZ
        case .translate: self = .translate
        case .translateX: self = .translateX
        case .translateY: self = .translateY
        case .translateZ: self = .translateZ
        default:
            fatalError()
        }
    }
    public func converted() -> CAValueFunction? {
        switch self {
        case .rotateX: .init(name: .rotateX)
        case .rotateY: .init(name: .rotateY)
        case .rotateZ: .init(name: .rotateZ)
        case .scale: .init(name: .scale)
        case .scaleX: .init(name: .scaleX)
        case .scaleY: .init(name: .scaleY)
        case .scaleZ: .init(name: .scaleZ)
        case .translate: .init(name: .translate)
        case .translateX: .init(name: .translateX)
        case .translateY: .init(name: .translateY)
        case .translateZ: .init(name: .translateZ)
        }
    }
}
