//: [Previous](@previous)

import Foundation
import UIKit

typealias Action<Type, Input> = (Type) -> (Input) -> Void

class CustomBtn: UIButton {

	private var touchUpInsideObservers = [(CustomBtn) -> Void]()

	func addTouchUpInside<T: AnyObject>(_ target: T, action: @escaping Action<T, CustomBtn>) {
		touchUpInsideObservers.append { [weak target] view in
			// 1 option
			target.map(action)?(view)

			// 2 option
//			guard let target = target else {
//				return
//			}
//			action(target)(view)
		}
	}

	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		super.touchesEnded(touches, with: event)
		touchUpInsideObservers.forEach { action in
			action(self)
		}
	}
}

class MyVC: UIViewController {

	func presentCustomBtn() {
		let customBtn = CustomBtn()
		customBtn.addTouchUpInside(self, action: MyVC.btnDidTap)
		view.addSubview(customBtn)
	}

	private func btnDidTap(customBtn: CustomBtn) {
		print(customBtn)
	}
}

//: [Next](@next)
