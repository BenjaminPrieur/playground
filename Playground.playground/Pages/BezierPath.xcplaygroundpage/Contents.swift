//: [Previous](@previous)

import UIKit

let π:CGFloat = CGFloat(M_PI)

func waterDropPath() -> UIImage {

    let size = CGSize(width: 320, height: 80)
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

    let startAngle: CGFloat = π * 0.9
    let endAngle: CGFloat = π * 2 + π * 0.1

    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()
    CGContextSetFillColorWithColor(context, UIColor.clearColor().CGColor)
    CGContextFillRect(context, rect)


    //// Shadow Declarations
    let shadow = NSShadow()
    shadow.shadowColor = UIColor.yellowColor()
    shadow.shadowOffset = CGSize(width: 0.1, height: -1.1)
    shadow.shadowBlurRadius = 10

    let spaceBottom = rect.height*0.8
    //// Bezier Drawing
    let bezierPath = UIBezierPath()
    UIColor.blueColor().setFill()
    bezierPath.moveToPoint(CGPoint(x: 0, y: spaceBottom))
    bezierPath.addLineToPoint(CGPoint(x: rect.midX - 50, y: spaceBottom))
    bezierPath.addCurveToPoint(CGPoint(x: rect.midX - 29, y: rect.height*0.65),
                               controlPoint1: CGPoint(x: rect.midX - 50, y: spaceBottom),
                               controlPoint2: CGPoint(x: rect.midX - 30, y: spaceBottom))

    bezierPath.addArcWithCenter(CGPoint(x: rect.midX, y: rect.height*0.50), radius: 30, startAngle: startAngle, endAngle: endAngle, clockwise: true)

    bezierPath.addCurveToPoint(CGPoint(x: rect.midX + 50, y: spaceBottom),
                               controlPoint1: CGPoint(x: rect.midX + 29, y: rect.height*0.65),
                               controlPoint2: CGPoint(x: rect.midX + 29, y: spaceBottom))

    bezierPath.addLineToPoint(CGPoint(x: rect.midX + 50, y: spaceBottom))
    bezierPath.addLineToPoint(CGPoint(x: rect.width, y: spaceBottom))

    bezierPath.addLineToPoint(CGPoint(x: rect.width, y: rect.height))
    bezierPath.addLineToPoint(CGPoint(x: 0, y: rect.height))

    bezierPath.lineCapStyle = .Round;

    bezierPath.lineJoinStyle = .Bevel;

    CGContextSaveGState(context)
    CGContextSetShadowWithColor(context, shadow.shadowOffset, shadow.shadowBlurRadius, (shadow.shadowColor as! UIColor).CGColor)
    UIColor.blackColor().setStroke()
    bezierPath.lineWidth = 2
    bezierPath.stroke()
    bezierPath.fill()
    CGContextRestoreGState(context)

    //This code must always be at the end of the playground
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return image
}

waterDropPath()

//: [Next](@next)
