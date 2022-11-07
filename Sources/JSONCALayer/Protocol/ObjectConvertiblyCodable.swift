//
//  ObjectConvertible.swift
//  
//
//  Created by p-x9 on 2022/11/03.
//  
//

import Foundation

protocol ObjectConvertiblyCodable: Codable {
    associatedtype Target: AnyObject

    func applyProperties(to layer: Target)
    func converted() -> Target?
}

extension ObjectConvertiblyCodable {
    func applyProperties(to layer: Target) {}
}
