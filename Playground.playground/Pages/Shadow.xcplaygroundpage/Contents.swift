//: [Previous](@previous)

import UIKit

//class UIViewShadow: UIView {
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layer.shadowColor = UIColor.blackColor().CGColor
//        layer.shadowOpacity = 1
//        layer.shadowRadius = 5
////        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: myView.frame.width, height: myView.frame.height)).CGPath
//    }
//}

func drawnViewWithShadow() -> UIView {

    let viewBackground = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    viewBackground.backgroundColor = UIColor.whiteColor()

    let view = UIView(frame: CGRectMake(20, 20, 50, 50))
    view.backgroundColor = UIColor.redColor()
    view.layer.masksToBounds = false
    view.layer.shadowColor = UIColor.blackColor().CGColor
    view.layer.shadowOffset = CGSizeMake(0.0, 0.0)
    view.layer.shadowRadius = 30.0
    view.layer.shadowOpacity = 1.0

//    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//    label.text = "TEST"
//    label.textColor = UIColor.whiteColor()
//    view.addSubview(label)
//    label.layer.shadowOffset = CGSizeMake(5, 5)
//    label.layer.shadowColor = UIColor.blackColor().CGColor
//    label.layer.shadowRadius = 5
//    label.layer.shadowOpacity = 1

//    view.layer.masksToBounds = false
//    view.clipsToBounds = false
//    view.layer.shadowPath = UIBezierPath(rect: view.frame).CGPath

    viewBackground.addSubview(view)
    return viewBackground
}

drawnViewWithShadow()

//let containerView = UIView(frame: CGRectMake(0, 0, 100, 100))


//let view = UIView(frame: CGRectMake(20, 20, 50, 50))
//view.backgroundColor = UIColor.redColor()
//view.layer.masksToBounds = false
//view.layer.shadowColor = UIColor.greenColor().CGColor
//view.layer.shadowOffset = CGSizeMake(0.0, 1.0)
//view.layer.shadowRadius = 2.0
//view.layer.shadowOpacity = 1.0
//
//containerView.addSubview(view)
//
//containerView


//: [Next](@next)
