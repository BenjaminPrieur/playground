//: [Previous](@previous)

import UIKit

// *********************************************************************
// MARK: - Cell

protocol ActionCellDelegate: class {
	func btnDidTap()
}

class ActionCell: UICollectionViewCell {

	weak var delegate: ActionCellDelegate?

	func testDelegate() {
		delegate?.btnDidTap()
	}
}

// *********************************************************************
// MARK: - DataSource

protocol CustomDataSourceDelegate: class, ActionCellDelegate {
	func registerCell()
}

class CustomDataSource: NSObject, UICollectionViewDataSource {

	weak var delegate: CustomDataSourceDelegate?
//	var items: [String: [Any]]

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath) as? ActionCell {
			cell.delegate = delegate
		}
		return UICollectionViewCell()
	}
}

// *********************************************************************
// MARK: - ViewController

class ViewController: UIViewController, CustomDataSourceDelegate {

	var dataSource: CustomDataSource?

	internal func registerCell() {
	}

	internal func btnDidTap() {
	}

}

//: [Next](@next)
