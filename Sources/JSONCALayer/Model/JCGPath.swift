//
//  JCGPath.swift
//  
//
//  Created by p-x9 on 2022/11/07.
//  
//

import UIKit

public class JCGPath: ObjectConvertiblyCodable {
    public typealias Target = CGPath

    var pathElements: [JCGPathElement]?

    init(pathElements: [JCGPathElement]?) {
        self.pathElements = pathElements
    }

    required convenience public init(with object: CGPath) {
        let pathElements = object.jelements
        self.init(pathElements: pathElements)
    }

    public func converted() -> CGPath? {
        let path = CGMutablePath()

        pathElements?
            .filter {
                let isValid = $0.elementType != nil && $0.elementType!.numberOfPoints <= $0.points.count
                if !isValid {
                    print("⚠️[warning] JSONCALayer invalid path element")
                }
                return isValid
            }
            .forEach {
                let points = $0.points
                switch $0.elementType {
                case .moveToPoint:
                    path.move(to: points[0])
                case .addLineToPoint:
                    path.addLine(to: points[0])
                case .addQuadCurveToPoint:
                    path.addQuadCurve(to: points[0], control: points[1])
                case .addCurveToPoint:
                    path.addCurve(to: points[0], control1: points[1], control2: points[2])
                case .closeSubpath:
                    path.closeSubpath()
                case .none:
                    break
                @unknown default:
                    break
                }
            }

        return path
    }
}


public struct JCGPathElement: Codable {
    public var type: String
    public var points: [CGPoint]

    public var elementType: CGPathElementType? {
        .init(string: type)
    }
}

public extension CGPath {
    var jelements: [JCGPathElement] {
        elements.map {
            let type = $0.type
            let points = Array(UnsafeBufferPointer(start: $0.points, count: type.numberOfPoints))
            return .init(type: type.string, points: points)
        }
    }
}
