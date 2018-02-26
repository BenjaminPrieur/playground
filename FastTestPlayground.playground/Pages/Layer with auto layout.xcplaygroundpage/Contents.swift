//: [Previous](@previous)

// https://marcosantadev.com/calayer-auto-layout-swift/
// https://gist.github.com/ffried/2e1176e302f8f37100b1eb00cb5f2b7d

import UIKit

open class LayerView<Layer: CALayer>: UIView {
	public final override class var layerClass: Swift.AnyClass {
		return Layer.self
	}

	public final var concreteLayer: Layer {
		return layer as! Layer
	}
}

//: [Next](@next)
