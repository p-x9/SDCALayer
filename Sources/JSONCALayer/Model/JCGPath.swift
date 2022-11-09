//
//  JCGPath.swift
//  
//
//  Created by p-x9 on 2022/11/07.
//  
//

import UIKit

class JCGPath: ObjectConvertiblyCodable {
    typealias Target = CGPath

    private enum CodingKeys: String, CodingKey {
        case bezierPath
    }

    var bezierPath: UIBezierPath?

    init(bezierPath: UIBezierPath?) {
        self.bezierPath = bezierPath
    }

    required convenience init(with object: CGPath) {
        let bezierPath = UIBezierPath(cgPath: object)
        self.init(bezierPath: bezierPath)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let data = try container.decode(Data.self, forKey: .bezierPath)
        bezierPath = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIBezierPath.self, from: data)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        guard let bezierPath else { return }
        let data = try NSKeyedArchiver.archivedData(withRootObject: bezierPath, requiringSecureCoding: false)
        try container.encode(data, forKey: .bezierPath)
    }

    func converted() -> CGPath? {
        bezierPath?.cgPath
    }
}
