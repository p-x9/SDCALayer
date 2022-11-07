//
//  WritableKeyPathWithValue.swift
//  
//
//  Created by p-x9 on 2022/11/04.
//  
//

import Foundation

/// Writable KeyPath and value
public struct WritableKeyPathWithValue<Root> {
    /// KeyPath to which you want to assign a value
    public let keyPath: PartialKeyPath<Root>
    /// Value to be assigned
    public let value: Any
    /// assign value
    public let apply: (inout Root) -> Void

    /// initialize with keyPath and value
    public init<Value>(_ keyPath: WritableKeyPath<Root, Value>, _ value: Value) {
        self.keyPath = keyPath
        self.value = value
        self.apply = { $0[keyPath: keyPath] = value }
    }
}

extension WritableKeyPathWithValue {
    public init(_ keyValueApplier: WritableKeyPathValueApplier<Root>, value: Any) {
        self.keyPath = keyValueApplier.keyPath
        self.value = value
        self.apply = {
            keyValueApplier.apply(value, &$0)
        }
    }
}
