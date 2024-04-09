//
//  CAMediaTimingFunction+.swift
//
//
//  Created by p-x9 on 2024/04/06.
//  
//

import QuartzCore

extension CAMediaTimingFunction {
    var controlPoints: [CGPoint] {
        var controlPoints = [CGPoint]()
        for index in 1..<3 {
            let controlPoint = UnsafeMutablePointer<Float>.allocate(capacity: 2)
            getControlPoint(at: Int(index), values: controlPoint)
            let x: Float = controlPoint[0]
            let y: Float = controlPoint[1]
            controlPoint.deallocate()
            controlPoints.append(CGPoint(x: CGFloat(x), y: CGFloat(y)))
        }
        return controlPoints
    }

    var name: CAMediaTimingFunctionName? {
        switch description {
        case "linear": .linear
        case "easeIn": .easeIn
        case "easeOut": .easeOut
        case "easeInEaseOut": .easeInEaseOut
        case "default": .default
        default: nil
        }
    }
}
