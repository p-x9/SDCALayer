//
//  CALayerConvertible.swift
//  
//
//  Created by p-x9 on 2022/11/06.
//  
//

import Foundation

protocol CALayerConvertible: ObjectConvertiblyCodable {
    func convertToLayer() -> Target?
}

extension CALayerConvertible {
    func converted() -> Target? {
        self.convertToLayer()
    }
}
