import Foundation
import UIKit

// UI = fn(state)
// state = json
// json = backend

// UI = fn(backend)

public protocol Component {
	var view: UIView? { get }
	var preferredViewSize: CGSize { get }
	var layoutTraits: [LayoutTraits] { get }

	func loadView()
	func configureWith(model: ComponentModel)
}

public enum LayoutTraits {
	case fullWitdh
	case stackable
	case compactWitdh
	case divider
}

public class ComponentModel {}
