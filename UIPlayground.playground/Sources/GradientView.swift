import Foundation
import UIKit

open class GradientView: UIView {

	// mark: - properties
	var gradientLayer: CAGradientLayer? {
		return self.layer as? CAGradientLayer
	}

	// mark: - lifecycle
	override open class var layerClass: AnyClass {
		return CAGradientLayer.self
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required public init?(coder aDecoder: NSCoder) {

		super.init(coder: aDecoder)
		setupView()
	}

	// mark: - setup methods
	private func setupView() {
		autoresizingMask = [.flexibleWidth, .flexibleHeight]
		if let gLayer = gradientLayer {
			gLayer.frame = bounds
		}
	}
}
