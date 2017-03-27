//: [Previous](@previous)

import UIKit

enum Result<T> {
	case success(T)
	case failure(Error)
}

class TileSection {}

// *********************************************************************
// MARK: - Manager

class Manager {

	func fetchLive(completion: @escaping (Result<TileSection>) -> Void) {
		completion(.success(TileSection()))
	}
}

// *********************************************************************
// MARK: - Provider

class Provider<T> {
	func loadData(completion: @escaping (Result<T>) -> Void) {
		fatalError("must be implemented")
	}
}

class TileSectionProvider: Provider<[TileSection]> {

	override func loadData(completion: @escaping (Result<[TileSection]>) -> Void) {
		Manager().fetchLive { result in
			switch result {
			case .success(let tileSection):
				completion(.success([tileSection]))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}

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
	var items: [TileSection] = []
	var provider: Provider<[TileSection]>

	init(provider: Provider<[TileSection]>) {
		self.provider = provider
	}

	func loadData() {
		provider.loadData { result in

		}
	}

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

let provider = TileSectionProvider()
let dataSource = CustomDataSource(provider: provider)
dataSource.loadData()

//: [Next](@next)
