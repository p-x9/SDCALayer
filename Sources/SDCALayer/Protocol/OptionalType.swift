//
//  OptionalType.swift
//
//
//  Created by p-x9 on 2024/04/03.
//  
//

import Foundation

public protocol OptionalType {
    associatedtype Wrapped

    var wrapped: Wrapped? { get }
}

extension Optional: OptionalType {
    public var wrapped: Wrapped? { self }
}
