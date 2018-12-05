//: [Previous](@previous)

import UIKit

// *********************************************************************
// MARK: - #1
// If your controller is in a navigation stack then its preferredStatusBarStyle won’t get called, rather its navigation controller’s preferredStatusBarStyle gets called. This snippet makes sure that your current controller’s preferredStatusBarStyle gets called everytime so that you can configure it in the respective controller 🚀

extension UINavigationController {

	open override var preferredStatusBarStyle: UIStatusBarStyle {
		return topViewController?.preferredStatusBarStyle ?? .default
	}
}

// *********************************************************************
// MARK: - #2
// If you simply conform your custom class with Describable protocol then you get typeName on it for free which prints its name

protocol Describable	{
	var typeName: String { get }
	static var typeName: String { get }
}

extension Describable {
	var typeName: String {
		return String(describing: self)
	}
	static var typeName: String {
		return String(describing: self)
	}
}

extension Describable where Self: NSObjectProtocol {
	var typeName: String {
//        let type = type(of: self)
		return String(describing: self)
	}
}

// *********************************************************************
// MARK: - #3
// Generic Typealias
typealias Closure<T> = (T) -> Void

// *********************************************************************
// MARK: - #4
// Optional?
extension Optional {

	var not: Bool {
		switch self {
		case .none:
			return false
		case .some(let wrapped):
			if let value = wrapped as? Bool {
				return !value
			} else {
				return false
			}
		}
	}
}

//: [Next](@next)
