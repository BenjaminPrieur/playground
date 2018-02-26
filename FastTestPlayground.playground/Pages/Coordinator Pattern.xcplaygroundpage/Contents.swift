//: [Previous](@previous)

// https://www.swiftbysundell.com/posts/navigation-in-swift

import Foundation
import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
	func onboardingViewControllerNextButtonTapped(_ viewController: OnboardingViewController)
}

class OnboardingViewController: UIViewController {

	private let page: OnboardingPage
	weak var delegate: OnboardingViewControllerDelegate?

	init(page: OnboardingPage) {
		self.page = page
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError()
	}

	private func handleNewButtonTap() {
		delegate?.onboardingViewControllerNextButtonTapped(self)
	}
}

protocol OnboardingCoordinatorDelegate: AnyObject {
	func onboardingCoordinatorDidFinish(_ onboardingCoordinator: OnboardingCoordinator)
}

enum OnboardingPage: Int {
	case start
	case mid
	case end
}

class OnboardingCoordinator: OnboardingViewControllerDelegate {

	weak var delegate: OnboardingCoordinatorDelegate?

	private let navigationController: UINavigationController
	private var nextPageIndex = 0

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func activate() {
		goToNextPageOrFinish()
	}

	func onboardingViewControllerNextButtonTapped(_ viewController: OnboardingViewController) {
		goToNextPageOrFinish()
	}

	private func goToNextPageOrFinish() {
		guard let page = OnboardingPage(rawValue: nextPageIndex) else {
			delegate?.onboardingCoordinatorDidFinish(self)
			return
		}

		let nextVC = OnboardingViewController(page: page)
		nextVC.delegate = self
		navigationController.pushViewController(nextVC, animated: true)

		nextPageIndex += 1
	}
}

//: [Next](@next)
