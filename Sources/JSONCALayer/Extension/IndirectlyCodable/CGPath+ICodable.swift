//
//  CGPath+ICodable.swift
//  
//
//  Created by p-x9 on 2022/11/10.
//  
//

import QuartzCore

extension CGPath: IndirectlyCodable {
    public typealias Target = JCGPath

    public func codable() -> JCGPath? {
        .init(with: self)
    }
}
