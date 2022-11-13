//
//  CGPath+.swift
//  
//
//  Created by p-x9 on 2022/11/13.
//  
//

import QuartzCore

extension CGPath {
    public var elements: [CGPathElement] {
        var elements = [CGPathElement]()
        self.applyWithBlock { elementPtr in
            let element = elementPtr.pointee
            elements.append(element)
        }
        return elements
    }
}

extension CGPathElementType: Codable {}

extension CGPathElementType {
    var numberOfPoints: Int {
        switch self {
        case .moveToPoint, .addLineToPoint:
            return 1
        case .addQuadCurveToPoint:
            return 2
        case .addCurveToPoint:
            return 3
        case .closeSubpath:
            return 0
        @unknown default:
            fatalError()
        }
    }

    var string: String {
        switch self {
        case .moveToPoint:
            return "moveToPoint"
        case .addLineToPoint:
            return "addLineToPoint"
        case .addQuadCurveToPoint:
            return "addQuadCurveToPoint"
        case .addCurveToPoint:
            return "addCurveToPoint"
        case .closeSubpath:
            return "closeSubpath"
        @unknown default:
            fatalError()
        }
    }

    init?(string: String) {
        switch string {
        case "moveToPoint": self = .moveToPoint
        case "addLineToPoint": self = .addLineToPoint
        case "addQuadCurveToPoint": self = .addQuadCurveToPoint
        case "addCurveToPoint": self = .addCurveToPoint
        case "closeSubpath": self = .closeSubpath
        default: return nil
        }
    }
}
