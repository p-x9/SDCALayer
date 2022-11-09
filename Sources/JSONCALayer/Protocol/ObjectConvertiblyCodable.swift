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

    func applyProperties(to layer: Target)
    func converted() -> Target?
}

public extension ObjectConvertiblyCodable {
    func applyProperties(to layer: Target) {}
}
