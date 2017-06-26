//: [Previous](@previous)

import Foundation
import UIKit

// http://irace.me/navigation-coordinators

final class LoginViewController: UIViewController {

	func signUpButtonTapped() {
		let accountCreationCoordinator = AccountCreationCoordinator(rootViewController: currentViewController, delegate: self)
		accountCreationCoordinator.start()

		/*
			We should assume that every coordinator may eventually maintain an array of
			child coordinators, which allows us to nest them and ensure that everything
			stays retained as long as it needs to be.
		*/
		childCoordinators.append(accountCreationCoordinator)
	}
}

final class AccountCreationCoordinator {

	// MARK: - Inputs
	private let rootViewController: UIViewController
	private weak var delegate: AccountCreationCoordinatorDelegate?

	// MARK: - Mutable state
	private let storage = Storage()

	private lazy var navigationController: UINavigationController = UINavigationController(UserNameAndPasswordViewController(delegate: self))

	// MARK: - Initialization
	init(rootViewController: UIViewController, delegate: AccountCreationCoordinatorDelegate) {
		self.rootViewController = rootViewController
	}

	// MARK: - Coordinator
	func start() {
		rootViewController.presentViewController(navigationController, animated: false)
	}
}

// MARK: - UserNameAndPasswordViewControllerDelegate

extension AccountCreationCoordinator: UserNameAndPasswordViewControllerDelegate {
	func userNameAndPasswordViewController(viewController: UserNameAndPasswordViewController,
	                                       didSubmitCredentials credentials: Credentials) {
		storage.credentials = credentials

		let avatarSelectionCoordinator = AvatarSelectionCoordinator(delegate: self)
		childCoordinators.append(avatarSelectionCoordinator)

		navigationController.pushViewController(avatarSelectionCoordinator.rootViewController,
		                                        animated: true)
	}
}

protocol RootViewControllerProvider: class {
	var rootViewController: UIViewController { get }
}

typealias RootCoordinator = protocol<Coordinator, RootViewControllerProvider>

final class NavigationController: UIViewController {
	// MARK: - Inputs

	private let rootViewController: UIViewController

	// MARK: - Mutable state

	private var viewControllersToChildCoordinators: [UIViewController: Coordinator] = [:]

	// MARK: - Lazy views

	private lazy var childNavigationController: UINavigationController =
		UINavigationController(rootViewController: self.rootViewController)

	// MARK: - Initialization

	init(rootViewController: UIViewController) {
		self.rootViewController = rootViewController

		super.init(nibName: nil, bundle: nil)
	}

	// MARK: - UIViewController

	override func viewDidLoad() {
		super.viewDidLoad()

		childNavigationController.delegate = self
		childNavigationController.interactivePopGestureRecognizer?.delegate = self

		addChildViewController(childNavigationController)
		view.addSubview(childNavigationController.view)
		childNavigationController.didMoveToParentViewController(self)

		childNavigationController.view.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activateConstraints([
			childNavigationController.view.topAnchor.constraintEqualToAnchor(view.topAnchor),
			childNavigationController.view.leftAnchor.constraintEqualToAnchor(view.leftAnchor),
			childNavigationController.view.rightAnchor.constraintEqualToAnchor(view.rightAnchor),
			childNavigationController.view.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor)
			])
	}

	// MARK: - Public

	func pushCoordinator(coordinator: RootCoordinator, animated: Bool) {
		viewControllersToChildCoordinators[coordinator.rootViewController] = coordinator

		pushViewController(coordinator.rootViewController, animated: animated)
	}

	func pushViewController(viewController: UIViewController, animated: Bool) {
		childNavigationController.pushViewController(viewController, animated: animated)
	}
}

// MARK: - UIGestureRecognizerDelegate

extension NavigationController: UIGestureRecognizerDelegate {
	func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
	                       shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
		// Necessary to get the child navigation controller’s interactive pop gesture recognizer to work.
		return true
	}
}

// MARK: - UINavigationControllerDelegate

extension NavigationController: UINavigationControllerDelegate {
	func navigationController(navigationController: UINavigationController,
	                          didShowViewController viewController: UIViewController, animated: Bool) {
		cleanUpChildCoordinators()
	}

	// MARK: - Private

	private func cleanUpChildCoordinators() {
		for viewController in viewControllersToChildCoordinators.keys {
			if !childNavigationController.viewControllers.contains(viewController) {
				viewControllersToChildCoordinators.removeValueForKey(viewController)
			}
		}
	}
}

//: [Next](@next)
