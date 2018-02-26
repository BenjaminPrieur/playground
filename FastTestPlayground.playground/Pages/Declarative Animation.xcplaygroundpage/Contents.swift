//: [Previous](@previous)

import UIKit
import PlaygroundSupport

// *********************************************************************
// MARK: - Models

public struct Animation {
	public let duration: TimeInterval
	public let closure: (UIView) -> Void
}

public extension Animation {
	static func fadeIn(duration: TimeInterval = 0.3) -> Animation {
		return Animation(duration: duration, closure: { $0.alpha = 1 })
	}

	static func resize(to size: CGSize, duration: TimeInterval = 0.3) -> Animation {
		return Animation(duration: duration, closure: { $0.bounds.size = size })
	}

	static func move(to point: CGPoint, duration: TimeInterval = 0.3) -> Animation {
		return Animation(duration: duration, closure: { $0.frame.origin = point })
	}
}

public extension UIView {
	func animate(_ animations: [Animation]) {
		// Exit condition: once all animations have been performed, we can return
		guard !animations.isEmpty else {
			return
		}

		// Remove the first animation from the queue
		var animations = animations
		let animation = animations.removeFirst()

		// Perform the animation by calling its closure
		UIView.animate(withDuration: animation.duration, animations: {
			animation.closure(self)
		}, completion: { _ in
			// Recursively call the method, to perform each animation in sequence
			self.animate(animations)
		})
	}

	func animate(inParallel animations: [Animation]) {
		for animation in animations {
			UIView.animate(withDuration: animation.duration) {
				animation.closure(self)
			}
		}
	}
}

// *********************************************************************
// MARK: - Sample

let view = UIView(frame: CGRect(
	x: 0, y: 0,
	width: 500, height: 500
))

view.backgroundColor = .white

PlaygroundPage.current.liveView = view

let animationView = UIView(frame: CGRect(
	x: 0, y: 0,
	width: 50, height: 50
))

animationView.backgroundColor = .red
animationView.alpha = 0
view.addSubview(animationView)

//animationView.animate([
//	.fadeIn(duration: 3),
//	.resize(to: CGSize(width: 200, height: 200), duration: 3)
//])

animationView.animate(inParallel: [
	.fadeIn(duration: 5),
	.move(to: CGPoint(x: 300, y: 300), duration: 5),
	.resize(to: CGSize(width: 200, height: 200), duration: 5)
])

//: [Next](@next)
