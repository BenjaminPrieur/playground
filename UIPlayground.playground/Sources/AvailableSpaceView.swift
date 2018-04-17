import Foundation
import UIKit

open class AvailableSpaceView: UIView {

	@IBOutlet private weak var leftLabel: UILabel!
	@IBOutlet private weak var rightLabel: UILabel!
	@IBOutlet private weak var spaceView: GradientView!

	override public init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .yellow
	}

	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}
