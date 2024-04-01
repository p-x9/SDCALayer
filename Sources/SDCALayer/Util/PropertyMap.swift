//
//  PropertyMap.swift
//
//
//  Created by p-x9 on 2022/11/21.
//
//

import Foundation
import IndirectlyCodable
import KeyPathValue

public typealias PropertyMap<Target: AnyObject, Object: AnyObject> = [PartialKeyPath<Object>: ReferenceWritableKeyPathValueApplier<Target>]

extension PropertyMap {
    /// ObjectConvertiblyCodable -> IndirectlyCodable
    /// (Codable -> IndirectlyCodable)
    public func apply<Target: AnyObject, Object: AnyObject>(
        to target: Target,
        from object: Object
    ) where Key: PartialKeyPath<Object>,
            Value == ReferenceWritableKeyPathValueApplier<Target>,
            Target: IndirectlyCodable,
            Object: ObjectConvertiblyCodable
    {
        self.forEach { keyPath, applier in
            var value = object[keyPath: keyPath]
            switch value {
            case let v as (any ObjectConvertiblyCodable):
                guard let codable = v.converted() else { return }
                value = codable

            case let v as [any ObjectConvertiblyCodable]:
                value = v.compactMap { $0.converted() }

            default:
                break
            }
            applier.apply(value, target)
        }
    }
}

extension PropertyMap {
    /// IndirectlyCodable -> ObjectConvertiblyCodable
    /// (IndirectlyCodable -> Codable)
    @_disfavoredOverload
    public func apply<Target: AnyObject, Object: AnyObject>(
        to target: Target,
        from object: Object
    ) where Key: PartialKeyPath<Object>,
            Value == ReferenceWritableKeyPathValueApplier<Target>,
            Target: ObjectConvertiblyCodable,
            Object: IndirectlyCodable
    {
        self.forEach { keyPath, applier in
            var value = object[keyPath: keyPath]
            switch value {
            case let v as (any IndirectlyCodable):
                guard let codable = v.codable() else { return }
                value = codable

            case let v as [any IndirectlyCodable]:
                value = v.compactMap { $0.codable() }

            default:
                break
            }
            applier.apply(value, target)
        }
    }
}

import QuartzCore
extension PropertyMap {
    /// CALayer -> CALayerConvertible
    /// (CaLayer -> Codable)
    public func apply<Target: AnyObject, Object: AnyObject>(
        to target: Target,
        from object: Object
    ) where Key: PartialKeyPath<Object>,
            Value == ReferenceWritableKeyPathValueApplier<Target>,
            Target: ObjectConvertiblyCodable,
            Object: CALayer & IndirectlyCodable
    {
        self.forEach { keyPath, applier in
            var value = object[keyPath: keyPath]

            switch value {
            case let v as (any IndirectlyCodable):
                guard let codable = v.codable() else { return }
                value = codable

            case let v as [any IndirectlyCodable]:
                value = v.compactMap { $0.codable() }

            default:
                break
            }

            if let keyPath = keyPath._kvcKeyPathString,
               object.shouldArchiveValue(forKey: keyPath) {
                applier.apply(value, target)
            }
        }
    }
}
