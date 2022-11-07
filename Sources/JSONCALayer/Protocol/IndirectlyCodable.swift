//
//  IndirectlyCodable.swift
//  
//
//  Created by p-x9 on 2022/11/06.
//  
//

import Foundation


protocol IndirectlyCodable {
    associatedtype Target: ObjectConvertiblyCodable

    func codable() -> Target
}
