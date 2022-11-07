//
//  WritableKeyPathValueApplier.swift
//  
//
//  Created by p-x9 on 2022/11/04.
//  
//

import Foundation

public struct WritableKeyPathValueApplier<Root> {
    public let keyPath: PartialKeyPath<Root>
    public let apply: (Any, inout Root) -> Void

    public init<Value>(_ keyPath: WritableKeyPath<Root,Value>) {
        self.keyPath = keyPath
        self.apply = {
            guard let value = $0 as? Value else { return }
            $1[keyPath: keyPath] = value
        }
    }
}
