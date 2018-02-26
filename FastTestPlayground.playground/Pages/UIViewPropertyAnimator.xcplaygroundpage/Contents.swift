//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

final class MyViewController: UIViewController {

	var customView: UIView!
	var runningAnimators: [UIViewPropertyAnimator] = []

	override func viewDidLoad() {
		view.backgroundColor = .lightGray

		customView = UIView(frame: CGRect(x: 0, y: 100, width: 200, height: 200))
		customView.backgroundColor = .darkGray

		view.addSubview(customView)

		let btn = UIButton(frame: CGRect(origin: .init(x: 300, y: 100), size: .init(width: 200, height: 200)))
		btn.backgroundColor = .black
		btn.setTitle("coucou", for: .normal)
		btn.addTarget(self, action: #selector(btnDidTouch), for: .touchUpInside)
		view.addSubview(btn)

		view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:))))
	}

	@objc func btnDidTouch() {
		self.customView.transform = CGAffineTransform.identity
		self.customView.frame = CGRect(x: 0, y: 100, width: 200, height: 200)
		customView.backgroundColor = .darkGray
	}

	@objc func handlePan(recognizer: UIPanGestureRecognizer) {

		switch recognizer.state {

		case .began:
			animateTransitionIfNeeded(duration: 1)

		case .changed:
			let translation = recognizer.translation(in: customView)
			updateInteractiveTransition(fractionComplete: translation.x / 100)

		case .ended:
			let translation = recognizer.translation(in: customView)
			let complete: Bool = (translation.x / 100) > 0.5
			continueInteractiveTransition(cancel: !complete)

		default: break
		}
	}

	func animateTransitionIfNeeded(duration: TimeInterval) {
		if runningAnimators.isEmpty {

			//			let timing = UICubicTimingParameters(controlPoint1: CGPoint(x: 0.75, y: 0.1), controlPoint2: CGPoint(x: 0.9, y: 0.25))
			//			animator = UIViewPropertyAnimator(duration: 1, timingParameters: timing)
			//			animator.addAnimations {
			//				self.customView.backgroundColor = UIColor(white: 1, alpha: 1)
			//				self.customView.frame = CGRect(x: 100, y: 0, width: 300, height: 300)
			//			}
			//			animator.scrubsLinearly = false

			let viewAnimation = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
				self.customView.backgroundColor = UIColor(white: 1, alpha: 1)
				self.customView.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
			}

			viewAnimation.pauseAnimation()
			runningAnimators.append(viewAnimation)

			let transformAnimator =  UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
				let rotationAngle = CGFloat(Double.pi) * 0.05
				let scaleTransform = CGAffineTransform(rotationAngle: rotationAngle)
				self.customView.transform = scaleTransform
			}
			transformAnimator.pauseAnimation()
			runningAnimators.append(transformAnimator)
		}
	}

	func animateOrReverseRunningTransition(duration: TimeInterval) {
		if runningAnimators.isEmpty {
			animateTransitionIfNeeded(duration: 1)
		} else {
			for animator in runningAnimators {
				animator.isReversed = !animator.isReversed
			}
		}
	}

	func updateInteractiveTransition(fractionComplete: CGFloat) {
		for animator in runningAnimators {
			animator.fractionComplete = fractionComplete
		}
	}

	func continueInteractiveTransition(cancel: Bool) {
		for animator in runningAnimators {
			animator.isReversed = cancel
			animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
		}
		runningAnimators = []
	}
}

let vc = MyViewController()
vc.view.frame = .init(origin: .zero, size: .init(width: 375, height: 800))
PlaygroundPage.current.liveView = vc

//: [Next](@next)
