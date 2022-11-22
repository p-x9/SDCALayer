//
//  JCGPath.swift
//  
//
//  Created by p-x9 on 2022/11/07.
//  
//

import CoreGraphics

public class JCGPath: ObjectConvertiblyCodable {
    public typealias Target = CGPath

    public var pathElements: [JCGPathElement]?

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
                    print("⚠️[warning] SDCALayer invalid path element")
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
                    path.addQuadCurve(to: points[1], control: points[0])
                case .addCurveToPoint:
                    path.addCurve(to: points[2], control1: points[0], control2: points[1])
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
        var elements = [JCGPathElement]()
        forEach { element in
            let type = element.type
            var points = [CGPoint]()
            for i in 0..<type.numberOfPoints {
                points.append(element.points[i])
            }
            elements.append(.init(type: type.string, points: points))
        }
        return elements
    }
}
