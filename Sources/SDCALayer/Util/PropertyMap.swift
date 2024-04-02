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

public struct PropertyMap<Source: AnyObject, Destination: AnyObject> {
    public typealias Map<A: AnyObject, B: AnyObject> = [PartialKeyPath<A>: ReferenceWritableKeyPathValueApplier<B>]

    public typealias ForwardMap = Map<Source, Destination>
    public typealias ReverseMap = Map<Destination, Source>

    public let forwardMap: ForwardMap
    public let reverseMap: ReverseMap
}

extension PropertyMap {
    public struct MappingElement {
        public typealias MapElement<A: AnyObject, B: AnyObject> = (PartialKeyPath<A>, ReferenceWritableKeyPathValueApplier<B>)

        public typealias ForwardMapElement = MapElement<Source, Destination>
        public typealias ReverseMapElement = MapElement<Destination, Source>

        public let forwardMapElement: ForwardMapElement
        public let reverseMapElement: ReverseMapElement

        public init<Value>(
            _ sourceKeyPath: ReferenceWritableKeyPath<Source, Value>,
            _ destinationKeyPath: ReferenceWritableKeyPath<Destination, Value>
        ) {
            forwardMapElement = (sourceKeyPath, .init(destinationKeyPath))
            reverseMapElement = (destinationKeyPath, .init(sourceKeyPath))
        }

        public init<Value>(
            _ sourceKeyPath: ReferenceWritableKeyPath<Source, Value>,
            _ destinationKeyPath: ReferenceWritableKeyPath<Destination, Value?>
        ) {
            forwardMapElement = (sourceKeyPath, .init(destinationKeyPath))
            reverseMapElement = (destinationKeyPath, .init(sourceKeyPath))
        }
    }

    public init(_ elements: [MappingElement]) {
        forwardMap = Dictionary(uniqueKeysWithValues: elements.map(\.forwardMapElement))
        reverseMap = Dictionary(uniqueKeysWithValues: elements.map(\.reverseMapElement))
    }
}

extension PropertyMap.MappingElement {
    public init<SourceValue, DestinationValue>(
        _ sourceKeyPath: ReferenceWritableKeyPath<Source, SourceValue>,
        _ destinationKeyPath: ReferenceWritableKeyPath<Destination, DestinationValue?>
    ) where SourceValue: IndirectlyCodable, DestinationValue: IndirectlyCodableModel {
        forwardMapElement = (sourceKeyPath, .init(destinationKeyPath))
        reverseMapElement = (destinationKeyPath, .init(sourceKeyPath))
    }

    public init<SourceValue, DestinationValue>(
        _ sourceKeyPath: ReferenceWritableKeyPath<Source, SourceValue>,
        _ destinationKeyPath: ReferenceWritableKeyPath<Destination, DestinationValue?>
    ) where SourceValue: Sequence, DestinationValue: Sequence, SourceValue.Element: IndirectlyCodable, DestinationValue.Element: IndirectlyCodableModel {
        forwardMapElement = (sourceKeyPath, .init(destinationKeyPath))
        reverseMapElement = (destinationKeyPath, .init(sourceKeyPath))
    }


    public init<SourceValue, DestinationValue>(
        _ sourceKeyPath: ReferenceWritableKeyPath<Source, SourceValue>,
        _ destinationKeyPath: ReferenceWritableKeyPath<Destination, DestinationValue>
    ) {
        forwardMapElement = (sourceKeyPath, .init(destinationKeyPath))
        reverseMapElement = (destinationKeyPath, .init(sourceKeyPath))
    }
}

extension PropertyMap {
    /// IndirectlyCodable -> ObjectConvertiblyCodable
    /// (IndirectlyCodable -> Codable)
    @_disfavoredOverload
    public func apply(
        to target: Destination,
        from source: Source
    ) {
        forwardMap.forEach { keyPath, applier in
            var value = source[keyPath: keyPath]
            switch value {
            case let v as (any IndirectlyCodable):
                guard let codable = v.codable() else { return }
                value = codable

            case let v as [any IndirectlyCodable]:
                value = v.compactMap { $0.codable() }

            default:
                break
            }
            applier.apply(value, to: target)
        }
    }
}

extension PropertyMap {
    /// ObjectConvertiblyCodable -> IndirectlyCodable
    /// (Codable -> IndirectlyCodable)
    public func apply(
        to source: Source,
        from destination: Destination
    ) {
        reverseMap.forEach { keyPath, applier in
            var value = destination[keyPath: keyPath]
            switch value {
            case let v as (any IndirectlyCodableModel):
                guard let codable = v.converted() else { return }
                value = codable

            case let v as [any IndirectlyCodableModel]:
                value = v.compactMap { $0.converted() }

            default:
                break
            }
            applier.apply(value, to: source)
        }
    }
}

import QuartzCore

extension PropertyMap {
    /// CALayer -> CALayerConvertible
    /// (CaLayer -> Codable)
    public func apply(
        to target: Destination,
        from source: Source
    ) where Source: CALayer & IndirectlyCodable {
        forwardMap.forEach { keyPath, applier in
            var value = source[keyPath: keyPath]

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
               source.shouldArchiveValue(forKey: keyPath) {
                applier.apply(value, to: target)
            }
        }
    }
}
