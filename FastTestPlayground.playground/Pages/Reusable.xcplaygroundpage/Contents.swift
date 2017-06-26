//: [Previous](@previous)

import Foundation
import UIKit

public extension NSObject {

	public class var nameOfClass: String {
		return NSStringFromClass(self).components(separatedBy: ".").last!
	}
}

extension UICollectionView {

	func register(cellName: String) {
		register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
	}

	func register(headerCellName: String) {
		register(UINib(nibName: headerCellName, bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
		         withReuseIdentifier:headerCellName)
	}

	func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
		guard let cell = dequeueReusableCell(withReuseIdentifier: T.nameOfClass, for: indexPath) as? T else {
			fatalError("Could not deque cell")
		}
		return cell
	}
}

class TotoCell: UICollectionViewCell {}

class TotoVC: UIViewController, UICollectionViewDataSource {

	var collectionView: UICollectionView = UICollectionView()

	override func viewDidLoad() {
		collectionView.register(cellName: TotoCell.nameOfClass)
		collectionView.dataSource = self
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as TotoCell
		return cell
	}
}


//: [Next](@next)