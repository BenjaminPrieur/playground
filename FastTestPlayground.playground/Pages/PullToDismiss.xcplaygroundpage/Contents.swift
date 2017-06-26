//: [Previous](@previous)

import Foundation
import UIKit

// https://www.thorntech.com/2016/02/ios-tutorial-close-modal-dragging/

class DismissAnimator: NSObject {
}

extension DismissAnimator: UIViewControllerAnimatedTransitioning {
	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.6
	}

	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

		guard let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey),
			let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),
			let containerView = transitionContext.containerView() else {
    return
		}

		containerView.insertSubview(toVC.view, belowSubview: fromVC.view)

		let screenBounds = UIScreen.mainScreen().bounds
		let bottomLeftCorner = CGPoint(x: 0, y: screenBounds.height)
		let finalFrame = CGRect(origin: bottomLeftCorner, size: screenBounds.size)

		UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
				fromVC.view.frame = finalFrame
		}, completion: { _ in
				transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
		})
	}
}

//: [Next](@next)
