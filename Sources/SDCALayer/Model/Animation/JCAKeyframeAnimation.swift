//
//  JCAKeyframeAnimation.swift
//
//
//  Created by p-x9 on 2024/04/07.
//  
//

import QuartzCore

open class JCAKeyframeAnimation: JCAPropertyAnimation {
    public typealias Target = CAKeyframeAnimation

    private enum CodingKeys: String, CodingKey {
        case values
        case path
        case keyTimes
        case timingFunctions
        case calculationMode
        case tensionValues
        case continuityValues
        case biasValues
        case rotationMode
    }

    open override class var targetTypeName: String {
        String(reflecting: Target.self)
    }

    static private let propertyMap: PropertyMap<CAKeyframeAnimation, JCAKeyframeAnimation> = .init([
//        .init(\.values, \.values),
        .init(\.path, \.path),
//        .init(\.keyTimes, \.keyTimes),
        .init(\.timingFunctions, \.timingFunctions),
        .init(\.calculationMode, \.calculationMode),
//        .init(\.tensionValues, \.tensionValues),
//        .init(\.continuityValues, \.continuityValues),
//        .init(\.biasValues, \.biasValues),
        .init(\.rotationMode, \.rotationMode),
    ])

    public var values: [JCAAnimationAny]?
    public var path: JCGPath?
    public var keyTimes: [Float]?
    public var timingFunctions: [JCAMediaTimingFunction]?
    public var calculationMode: JCAAnimationCalculationMode?

    public var tensionValues: [Float]?
    public var continuityValues: [Float]?
    public var biasValues: [Float]?

    public var rotationMode: JCAAnimationRotationMode?

    public override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        values = try container.decodeIfPresent([JCAAnimationAny].self, forKey: .values)
        path = try container.decodeIfPresent(JCGPath.self, forKey: .path)
        keyTimes = try container.decodeIfPresent([Float].self, forKey: .keyTimes)
        timingFunctions = try container.decodeIfPresent([JCAMediaTimingFunction].self, forKey: .timingFunctions)
        calculationMode = try container.decodeIfPresent(JCAAnimationCalculationMode.self, forKey: .calculationMode)

        tensionValues = try container.decodeIfPresent([Float].self, forKey: .tensionValues)
        continuityValues = try container.decodeIfPresent([Float].self, forKey: .continuityValues)
        biasValues = try container.decodeIfPresent([Float].self, forKey: .biasValues)

        rotationMode = try container.decodeIfPresent(JCAAnimationRotationMode.self, forKey: .rotationMode)
    }

    open override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)

        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(values, forKey: .values)
        try container.encodeIfPresent(path, forKey: .path)
        try container.encodeIfPresent(keyTimes, forKey: .keyTimes)
        try container.encodeIfPresent(timingFunctions, forKey: .timingFunctions)
        try container.encodeIfPresent(calculationMode, forKey: .calculationMode)

        try container.encodeIfPresent(tensionValues, forKey: .tensionValues)
        try container.encodeIfPresent(continuityValues, forKey: .continuityValues)
        try container.encodeIfPresent(biasValues, forKey: .biasValues)

        try container.encodeIfPresent(rotationMode, forKey: .rotationMode)
    }

    public required convenience init(with object: Target) {
        self.init()

        applyProperties(with: object)
    }

    open override func applyProperties(to target: CAAnimation) {
        super.applyProperties(to: target)

        guard let target = target as? CAKeyframeAnimation else { return }

        Self.propertyMap.apply(to: target, from: self)

        target.values = values?.map(\.value)
        target.keyTimes = keyTimes?.map { NSNumber(value: $0) }
        target.tensionValues = tensionValues?.map { NSNumber(value: $0) }
        target.continuityValues = continuityValues?.map { NSNumber(value: $0) }
        target.biasValues = biasValues?.map { NSNumber(value: $0) }
    }

    open override func applyProperties(with target: CAAnimation) {
        super.applyProperties(with: target)

        guard let target = target as? CAKeyframeAnimation else { return }

        Self.propertyMap.apply(to: self, from: target)

        values = target.values?.compactMap { .init($0) }
        keyTimes = target.keyTimes?.map { $0.floatValue }
        tensionValues = target.tensionValues?.map { $0.floatValue }
        continuityValues = target.continuityValues?.map { $0.floatValue }
        biasValues = target.biasValues?.map { $0.floatValue }
    }

    open override func convertToAnimation() -> CAAnimation? {
        let animation = CAKeyframeAnimation()

        self.applyProperties(to: animation)
        return animation
    }
}

public final class JCAAnimationCalculationMode: RawIndirectlyCodableModel {
    public typealias Target = CAAnimationCalculationMode

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}

public final class JCAAnimationRotationMode: RawIndirectlyCodableModel {
    public typealias Target = CAAnimationRotationMode

    public var rawValue: Target.RawValue
    public required init(rawValue: Target.RawValue) {
        self.rawValue = rawValue
    }
}
