//
//  RawIndirectlyCodable.swift
//
//
//  Created by p-x9 on 2024/04/04.
//  
//

import Foundation
import IndirectlyCodable

public protocol RawIndirectlyCodable: RawRepresentable & IndirectlyCodable where RawValue: Codable, Model: RawIndirectlyCodableModel, Model.Target == Self {}

public protocol RawIndirectlyCodableModel: IndirectlyCodableModel where Target: RawIndirectlyCodable, Target.Model == Self {
    var rawValue: Target.RawValue { get }
    init(rawValue: Target.RawValue)
}

extension RawIndirectlyCodableModel {
    public init(with target: Target) {
        self.init(rawValue: target.rawValue)
    }

    public func converted() -> Target? {
        .init(rawValue: rawValue)
    }
}
//
//extension RawIndirectlyCodableModel {
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encode(rawValue)
//    }
//
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        let rawValue = try container.decode(Target.RawValue.self)
//        self.init(rawValue: rawValue)
//    }
//}
