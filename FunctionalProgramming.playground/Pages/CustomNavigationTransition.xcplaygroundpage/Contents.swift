//: [Previous](@previous)

import Foundation
import UIKit

// *********************************************************************
// MARK: - Link
// https://www.appcoda.com/custom-view-controller-transitions-tutorial/

class CustomNavigationAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

	var reverse: Bool = false

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 1.5
	}

	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let containerView = transitionContext.containerView
		let toViewController = transitionContext.viewController(forKey: .to)!
		let fromViewController = transitionContext.viewController(forKey: .from)!
		let toView = toViewController.view!
		let fromView = fromViewController.view!
		let direction: CGFloat = reverse ? -1 : 1
		let const: CGFloat = -0.005

		toView.layer.anchorPoint = CGPoint(x: direction == 1 ? 0 : 1, y: 0.5)
		fromView.layer.anchorPoint = CGPoint(x: direction == 1 ? 1 : 0, y: 0.5)

		var viewFromTransform: CATransform3D = CATransform3DMakeRotation(direction * CGFloat(M_PI_2), 0.0, 1.0, 0.0)
		var viewToTransform: CATransform3D = CATransform3DMakeRotation(-direction * CGFloat(M_PI_2), 0.0, 1.0, 0.0)
		viewFromTransform.m34 = const
		viewToTransform.m34 = const

		containerView.transform = CGAffineTransform(translationX: direction * containerView.frame.size.width / 2.0, y: 0)
		toView.layer.transform = viewToTransform
		containerView.addSubview(toView)

		UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
			containerView.transform = CGAffineTransform(translationX: -direction * containerView.frame.size.width / 2.0, y: 0)
			fromView.layer.transform = viewFromTransform
			toView.layer.transform = CATransform3DIdentity
		}, completion: { finished in
			containerView.transform = CGAffineTransform.identity
			fromView.layer.transform = CATransform3DIdentity
			toView.layer.transform = CATransform3DIdentity
			fromView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
			toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)

			if (transitionContext.transitionWasCancelled) {
				toView.removeFromSuperview()
			} else {
				fromView.removeFromSuperview()
			}
			transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
		})
	}

}


// *********************************************************************
// MARK: - 

class ItemsTableViewController: UITableViewController, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {

	let customNavigationAnimationController = CustomNavigationAnimationController()
	let customInteractionController = CustomInteractionController()

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.delegate = self
	}

	func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation,
	                          from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

		if operation == .push {
			customInteractionController.attachToViewController(viewController: toVC)
		}

		customNavigationAnimationController.reverse = operation == .pop
		return customNavigationAnimationController
	}

	func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
		return customInteractionController.transitionInProgress ? customInteractionController : nil
	}
}



class CustomInteractionController: UIPercentDrivenInteractiveTransition {
	var navigationController: UINavigationController!
	var shouldCompleteTransition = false
	var transitionInProgress = false
	var completionSeed: CGFloat {
		return 1 - percentComplete
	}

	func attachToViewController(viewController: UIViewController) {
		navigationController = viewController.navigationController
		setupGestureRecognizer(view: viewController.view)
	}

	private func setupGestureRecognizer(view: UIView) {
		view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "handlePanGesture:"))
	}

	func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
		let viewTranslation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
		switch gestureRecognizer.state {
		case .began:
			transitionInProgress = true
			navigationController.popViewController(animated: true)
		case .changed:
			let const = CGFloat(fminf(fmaxf(Float(viewTranslation.x / 200.0), 0.0), 1.0))
			shouldCompleteTransition = const > 0.5
			update(const)
		case .cancelled, .ended:
			transitionInProgress = false
			if !shouldCompleteTransition || gestureRecognizer.state == .cancelled {
				cancel()
			} else {
				finish()
			}
		default:
			print("Swift switch must be exhaustive, thus the default")
		}
	}
}


//: [Next](@next)
