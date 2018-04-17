import Foundation
import UIKit

public extension UIView {
	func add(_ subviews: UIView...) {
		subviews.forEach(addSubview)
	}
}

//view.add(button)
//view.add(label)
//
//// By dropping the "Subview" suffix from the method name, both
//// single and multiple arguments work really well semantically.
//view.add(button, label)

