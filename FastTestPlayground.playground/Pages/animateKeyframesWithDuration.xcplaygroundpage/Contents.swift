//: [Previous](@previous)

import UIKit

UIView.animateKeyframes(withDuration: 4, delay: 0, options: .calculationModeCubic, animations: {
	UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
//		snapshot.frame = smallFrame
	}
	UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
//		snapshot.frame = finalFrame
	}
}, completion: nil)

//: [Next](@next)
