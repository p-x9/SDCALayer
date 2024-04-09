//
//  CAValueFunction+ICodable.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore
import IndirectlyCodable

extension CAValueFunction: IndirectlyCodable {
    public typealias Model = JCAValueFunction

    public func codable() -> Model? {
        .init(with: self)
    }
}
