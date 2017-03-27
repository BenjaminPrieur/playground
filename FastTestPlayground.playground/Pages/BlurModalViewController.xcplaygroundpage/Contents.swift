//: [Previous](@previous)

import Foundation
import UIKit

// ref: https://www.raizlabs.com/dev/2017/03/ibfree-practice-1-managing-modal/

/// All fonts in the app should be specified here.
enum AppFont {

	static func helvetica(size: CGFloat) -> UIFont {
		return font(name: "helvetica", size: size)
	}

	private static func font(name: String, size: CGFloat) -> UIFont {
		if let font = UIFont(name: name, size: size) {
			return font
		} else {
			print("Error loading font named \(name), returning system font")
			return UIFont.systemFont(ofSize: size)
		}
	}
}


/// All colors used in the app should be specified here
enum AppColor {
	static let clear = UIColor.clear
	static let lightGray = UIColor.lightGray
	static let raizlabsRed = AppColor.color(fromHex: 0xec594d)
	static let red = UIColor.red
	static let white = UIColor.white

	/// Generate UIColor from Hex. Adapted from Tom (http://stackoverflow.com/users/426478/tom) and Marcus Adam's (http://stackoverflow.com/users/168493/marcus-adams) Stack Overflow answer http://stackoverflow.com/a/3532264/4092717
	///
	/// - Parameters:
	///   - hex: Int (change # to 0x)
	///   - alpha: Double, default = 1
	/// - Returns: UIColor
	private static func color(fromHex hex: Int, alpha: CGFloat = 1.0) -> UIColor {
		let red = CGFloat((hex & 0xFF0000) >> 16) / 255
		let green = CGFloat((hex & 0xFF00) >> 8) / 255
		let blue = CGFloat((hex & 0xFF)) / 255
		return UIColor(red: red, green: green, blue: blue, alpha: alpha)
	}
}


/// A simple small X button used for dismissing modals
final class DismissButton: UIButton {

	init() {
		super.init(frame: CGRect.zero)

		backgroundColor = AppColor.clear
		tintColor = AppColor.white

		let image = #imageLiteral(resourceName: "icn-close")
		setImage(image, for: .normal)
	}

	@available(*, unavailable) required init?(coder aDecoder: NSCoder) {
		fatalError("this is a xibless class utilizing anchorage for autolayout, use init() instead")
	}
}



/// A modal with dark blurred background, dismiss button, and light UIStatusBar
class ModalViewController: UIViewController {

	fileprivate let blurView: UIVisualEffectView = {
		let effect = UIBlurEffect(style: UIBlurEffectStyle.dark)
		return UIVisualEffectView(effect: effect)
	}()

	fileprivate let dismissButton = DismissButton()

	override func viewDidLoad() {
		super.viewDidLoad()
		configureActions()
		configureView()
	}
}

// MARK: - Actions
private extension ModalViewController {

	func configureActions() {
		dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
	}

	@objc func dismissButtonTapped() {
		presentingViewController?.dismiss(animated: true, completion: nil)
	}
}

// MARK: - View Configuration
private extension ModalViewController {

	func configureView() {

		// View Hierarchy
		view.addSubview(blurView)
		view.addSubview(dismissButton)

		// Style
		view.backgroundColor = AppColor.clear
	}
}

// MARK: - UIViewContoller style overrides
extension ModalViewController {

	/// Modal presentation style is set to .overFullScreen to enable the blur effect
	override var modalPresentationStyle: UIModalPresentationStyle {
		get {
			return .overFullScreen
		}
		set {
			print("\(self): ignoring setting the modal presentation style: this controller is designed to be presented full screen and so should always be .overFullScreen (plus, it would kill the blur if its not .overFullScreen or .overCurrentContext)")
		}
	}

	/// Apple docs state that this value should be ignored when a view controller is presented full screen, but this doesn't appear to be the case, we still need to override it to control the status bar appearance (https://developer.apple.com/reference/uikit/uiviewcontroller/1621453-modalpresentationcapturesstatusb) Open radar here: http://openradar.appspot.com/30870230
	override var modalPresentationCapturesStatusBarAppearance: Bool {
		get {
			return true
		}
		set {
			print("\(self): ignoring setting the modalPresentationCapturesStatusBarAppearance style, it would not allow this controller to control the status bar")
		}
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}

//: [Next](@next)
