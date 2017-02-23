//: [Previous](@previous)

import UIKit

struct ProgramCategory {
	var id: String
	var type: String
	var slug: String
	var label: String
	var rank: String?
}

class Manager {
	func loadData() -> CustomDataSource {
		return CustomDataSource()
	}
}

class GenericPagerViewModel {
	var title: String
	var section: [ProgramCategory]
	var didSelectSection: (ProgramCategory) -> Void

	init(title: String, section: [ProgramCategory], didSelectSection: @escaping (ProgramCategory) -> Void) {
		self.title = title
		self.section = section
		self.didSelectSection = didSelectSection
	}
}

extension GenericPagerViewModel {
	static let bookmarksPagerViewModel = GenericPagerViewModel(title: "Bookmarks",
	                                                           section: [ProgramCategory(id: "1", type: "programCategory", slug: "", label: "programmes", rank: nil),
	                                                                     ProgramCategory(id: "2", type: "programCategory", slug: "", label: "personnalités", rank: nil),
	                                                                     ProgramCategory(id: "3", type: "programCategory", slug: "", label: "chaines", rank: nil)],
	                                                           didSelectSection: { programCategory in

																															let loadData = {
																																return Manager().loadData()
																															}

																															let tilesViewController = TilesViewController(programCategory: programCategory, loadData: loadData)
	})
}

class PagerViewController: UIViewController {

	var pagerViewModel: GenericPagerViewModel

	required init(pagerViewModel: GenericPagerViewModel) {
		self.pagerViewModel = pagerViewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError()
	}

	func selectItemAtIndex(index: Int) {
		guard index < pagerViewModel.section.count else {
			return
		}

		pagerViewModel.didSelectSection(pagerViewModel.section[index])
	}
}

class CustomDataSource {}

class TilesViewController: UIViewController {

	var programCategory: ProgramCategory
	var dataSource: CustomDataSource? {
		didSet {
			collectionView?.reloadData()
		}
	}
	var loadData: () -> CustomDataSource

	var collectionView: UICollectionView?

	required init(programCategory: ProgramCategory, loadData: @escaping () -> CustomDataSource) {

		self.programCategory = programCategory
		self.loadData = loadData

		super.init(nibName: nil, bundle: nil)
		print(programCategory.id)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		dataSource = loadData()
	}

}

//let pagerViewModel = GenericPagerViewModel()

let pagerViewController = PagerViewController(pagerViewModel: .bookmarksPagerViewModel)
pagerViewController.selectItemAtIndex(index: 0)

//: [Next](@next)
