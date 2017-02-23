//: [Previous](@previous)

import UIKit
import PlaygroundSupport

//: NSLayoutConstraint convenience methods
public extension NSLayoutConstraint {

	public static func pinning(attribute: NSLayoutAttribute, ofView firstView: UIView, toView secondView: UIView, multiplier: CGFloat = 1, offset: CGFloat = 0) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: firstView, attribute: attribute, relatedBy: .equal, toItem: secondView, attribute: attribute, multiplier: multiplier, constant: offset)
	}

	public static func pinning(attributes: [NSLayoutAttribute], ofView firstView: UIView, toView secondView: UIView, multiplier: CGFloat = 1, offset: CGFloat = 0) -> [NSLayoutConstraint] {
		return attributes.map { return NSLayoutConstraint(item: firstView, attribute: $0, relatedBy: .equal, toItem: secondView, attribute: $0, multiplier: multiplier, constant: offset) }
	}

	public static func pinningCenterOfView(_ firstView: UIView, toView secondView: UIView, offset: (CGPoint) = .zero) -> [NSLayoutConstraint] {
		let xConstraint = pinning(attribute: .centerX, ofView: firstView, toView: secondView, offset: offset.x)
		let yConstraint = pinning(attribute: .centerY, ofView: firstView, toView: secondView, offset: offset.y)
		return [xConstraint, yConstraint]
	}

	public static func pinningAttribute(attribute: NSLayoutAttribute, ofView view: UIView, toConstant constant: CGFloat) -> NSLayoutConstraint {
		return NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: constant)
	}

	public static func pinningSizeOfView(view: UIView, to size:CGSize) -> [NSLayoutConstraint] {
		let widthConstraint = NSLayoutConstraint.pinningAttribute(attribute: .width, ofView: view, toConstant: size.width)
		let heightConstraint = NSLayoutConstraint.pinningAttribute(attribute: .height, ofView: view, toConstant: size.height)
		return [widthConstraint, heightConstraint]
	}

}

//: UIView convenience methods
extension UIView {
	@discardableResult public func pinSubviewToCenter(_ subview: UIView, offset: CGPoint = .zero) -> (centerX: NSLayoutConstraint, centerY: NSLayoutConstraint)? {
		guard subview.superview == self else { return nil }
		let constraints = NSLayoutConstraint.pinningCenterOfView(subview, toView: self)
		self.addConstraints(constraints)
		return (centerX: constraints[0], centerY: constraints[1])
	}

	@discardableResult public func pinSize(_ size: CGSize) -> (width: NSLayoutConstraint, height: NSLayoutConstraint) {
		let constraints = NSLayoutConstraint.pinningSizeOfView(view: self, to: size)
		self.addConstraints(constraints)
		return (width: constraints[0], height: constraints[1])
	}

	@discardableResult public func pinSubviewToBounds(_ subview: UIView, offset: CGFloat = 0) -> (top: NSLayoutConstraint, left: NSLayoutConstraint, bottom: NSLayoutConstraint, right: NSLayoutConstraint)? {
		return pinSubviewToBounds(subview, ofView: self, offset: offset)
	}

	@discardableResult public func pinSubviewToBounds(_ subview: UIView, ofView view: UIView, offset: CGFloat = 0) -> (top: NSLayoutConstraint, left: NSLayoutConstraint, bottom: NSLayoutConstraint, right: NSLayoutConstraint)? {
		guard subview.superview == self, (view == self || view.superview == self) else { return nil }

		let constraints = NSLayoutConstraint.pinning(attributes: [.top, .left, .bottom, .right], ofView: subview, toView: view)
		self.addConstraints(constraints)
		return (top: constraints[0], left: constraints[1], bottom: constraints[2], right: constraints[3])
	}

	@discardableResult public func pinAttribute(_ subviewAttribute: NSLayoutAttribute, ofSubview subview: UIView, toAttribute attribute: NSLayoutAttribute, ofView view: UIView, multiplier: CGFloat = 1, offset: CGFloat = 0) -> NSLayoutConstraint? {
		guard subview.superview == self, (view == self || view.superview == self) else { return nil }

		let constraint = NSLayoutConstraint(item: subview, attribute: subviewAttribute, relatedBy: .equal, toItem: view, attribute: attribute, multiplier: multiplier, constant: offset)
		self.addConstraint(constraint)
		return constraint
	}
}

//: Test code
let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
view.backgroundColor = UIColor.black

let redView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
redView.translatesAutoresizingMaskIntoConstraints = false
redView.backgroundColor = UIColor.red
redView.pinSize(CGSize(width: 200, height: 200))
view.addSubview(redView)

let blueView = UIView(frame: .zero)
blueView.translatesAutoresizingMaskIntoConstraints = false
blueView.backgroundColor = UIColor.blue
blueView.pinSize(CGSize(width: 100, height: 100))
view.addSubview(blueView)

let greenView = UIView(frame: .zero)
greenView.translatesAutoresizingMaskIntoConstraints = false
greenView.backgroundColor = UIColor.green
greenView.pinSize(CGSize(width: 75, height: 75))
view.addSubview(greenView)

view.pinSubviewToCenter(blueView)
view.pinAttribute(.leading, ofSubview: greenView, toAttribute: .trailing, ofView: blueView)
view.pinAttribute(.bottom, ofSubview: greenView, toAttribute: .bottom, ofView: view, offset: -25)

PlaygroundPage.current.liveView = view

//: [Next](@next)
