//
//  ObjectConvertible.swift
//  
//
//  Created by p-x9 on 2022/11/03.
//  
//

import Foundation

public protocol ObjectConvertiblyCodable: Codable {
    associatedtype Target

    static var targetTypeName: String { get }

    init(with object: Target)
    func reverseApplyProperties(with target: Target)

    func applyProperties(to target: Target)
    func converted() -> Target?
}

public extension ObjectConvertiblyCodable {
    static var targetTypeName: String {
        String(reflecting: Target.self)
    }

    func reverseApplyProperties(with target: Target) {}
    func applyProperties(to layer: Target) {}
}
