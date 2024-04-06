//
//  CAMediaTimingFunction+ICodable.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore
import IndirectlyCodable

extension CAMediaTimingFunction: IndirectlyCodable {
    public typealias Model = JCAMediaTimingFunction

    public func codable() -> Model? {
        .init(with: self)
    }
}
