import UIKit

extension CGSize {

	// example: label.frame.origin = imageView.bounds.size + CGSize(width: 10, height: 20)
	static func +(lhs: CGSize, rhs: CGSize) -> CGPoint {
		return CGPoint(
			x: lhs.width + rhs.width,
			y: lhs.height + rhs.height
		)
	}


	// example: label.frame.origin = imageView.bounds.size + (10, 20)
	static func +(lhs: CGSize, rhs: (x: CGFloat, y: CGFloat)) -> CGPoint {
		return CGPoint(
			x: lhs.width + rhs.x,
			y: lhs.height + rhs.y
		)
	}
}
