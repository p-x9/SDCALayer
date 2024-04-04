//
//  CALayerConvertible.swift
//  
//
//  Created by p-x9 on 2022/11/06.
//  
//

import Foundation

public protocol CALayerConvertible: IndirectlyCodableModel {
    func convertToLayer() -> Target?
}

public extension CALayerConvertible {
    func converted() -> Target? {
        self.convertToLayer()
    }
}
