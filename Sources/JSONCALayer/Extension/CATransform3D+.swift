//
//  CATransform3D+.swift
//  
//
//  Created by p-x9 on 2022/11/18.
//  
//

import QuartzCore

extension CATransform3D: Codable {
    private enum CodingKeys: String, CodingKey {
        case m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(m11, forKey: .m11)
        try container.encode(m12, forKey: .m12)
        try container.encode(m13, forKey: .m13)
        try container.encode(m14, forKey: .m14)

        try container.encode(m21, forKey: .m21)
        try container.encode(m22, forKey: .m22)
        try container.encode(m23, forKey: .m23)
        try container.encode(m24, forKey: .m24)

        try container.encode(m31, forKey: .m31)
        try container.encode(m32, forKey: .m32)
        try container.encode(m33, forKey: .m33)
        try container.encode(m34, forKey: .m34)

        try container.encode(m41, forKey: .m41)
        try container.encode(m42, forKey: .m42)
        try container.encode(m43, forKey: .m43)
        try container.encode(m44, forKey: .m44)
    }

    public init(from decoder: Decoder) throws {
        self.init()

        let container = try decoder.container(keyedBy: CodingKeys.self)

        m11 = try container.decodeIfPresent(CGFloat.self, forKey: .m11) ?? 0
        m12 = try container.decodeIfPresent(CGFloat.self, forKey: .m12) ?? 0
        m13 = try container.decodeIfPresent(CGFloat.self, forKey: .m13) ?? 0
        m14 = try container.decodeIfPresent(CGFloat.self, forKey: .m14) ?? 0

        m21 = try container.decodeIfPresent(CGFloat.self, forKey: .m21) ?? 0
        m22 = try container.decodeIfPresent(CGFloat.self, forKey: .m22) ?? 0
        m23 = try container.decodeIfPresent(CGFloat.self, forKey: .m23) ?? 0
        m24 = try container.decodeIfPresent(CGFloat.self, forKey: .m24) ?? 0

        m31 = try container.decodeIfPresent(CGFloat.self, forKey: .m31) ?? 0
        m32 = try container.decodeIfPresent(CGFloat.self, forKey: .m32) ?? 0
        m33 = try container.decodeIfPresent(CGFloat.self, forKey: .m33) ?? 0
        m34 = try container.decodeIfPresent(CGFloat.self, forKey: .m34) ?? 0

        m41 = try container.decodeIfPresent(CGFloat.self, forKey: .m41) ?? 0
        m42 = try container.decodeIfPresent(CGFloat.self, forKey: .m42) ?? 0
        m43 = try container.decodeIfPresent(CGFloat.self, forKey: .m43) ?? 0
        m44 = try container.decodeIfPresent(CGFloat.self, forKey: .m44) ?? 0
    }
}
