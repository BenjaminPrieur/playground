//: [Previous](@previous)

import Foundation
import UIKit

// *********************************************************************
// MARK: - Link
// http://www.lanza.io/swift,/ios/2016/11/10/iOS-table-view-patterns.html

class MyTableViewController: UIViewController {
	let tableView = UITableView(frame: CGRect.zero, style: .plain)
}

// *********************************************************************
// MARK: - Protocol

protocol ConfigurableCell {
	associatedtype Object
	static var identifier: String { get }
	func configure(for object: Object, at indexPath: IndexPath)
}

protocol DataProvider {
	associatedtype Object
	func numberOfSections() -> Int
	func numberOfRows(in section: Int) -> Int
	func object(at indexPath: IndexPath) -> Object
}

class MyTableViewCell: UITableViewCell { //customize it here
}

extension MyTableViewCell: ConfigurableCell {
	typealias Object = String
	static var identifier: String { return "MyTableViewCell" }
  func configure(for object: String, at indexpath: IndexPath) {
		textLabel?.text = object
  }
}

class ArrayProvider<Type>: DataProvider {
	var objects: [Type]
	init(array: [Type]) {
		self.objects = array
	}
	func numberOfSections() -> Int { return 1}
	func numberOfRows(in section: Int) -> Int { return objects.count }
	func object(at indexPath: IndexPath) -> Type { return objects[indexPath.row] }
}

class DataSource<Provider: DataProvider, Cell: UITableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate where Cell: ConfigurableCell, Provider.Object == Cell.Object {

	let provider: Provider
	let tableView: UITableView

	init(tableView: UITableView, provider: Provider) {
		self.tableView = tableView
		self.provider = provider
		super.init()

		setup()
	}

	func setup() {
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return provider.numberOfSections()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return provider.numberOfRows(in: section)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as! Cell
		let object = provider.object(at: indexPath)
		cell.configure(for: object, at: indexPath)
		return cell
	}
}

class ArrayDataSource<Type, Cell: UITableViewCell>: DataSource<ArrayProvider<Type>, Cell> where Cell: ConfigurableCell, Cell.Object == Type {

	init(tableView: UITableView, array: [Type]) {
		let provider = ArrayProvider(array: array)
		super.init(tableView: tableView, provider: provider)
	}

	var objects: [Type] { return provider.objects }
}

// *********************************************************************
// MARK: - Sample

struct Author {
	var name: String
	var birthDate: Date
}

class AuthorCell: UITableViewCell { // set up views 
}

extension AuthorCell: ConfigurableCell {
	static var identifier: String { return "AuthorCell" }
	func configure(for object: Author, at indexPath: IndexPath) {
		textLabel?.text = object.name
		detailTextLabel?.text = "Born on: " //+ object.birthDateString
	}
}

class AuthorDataSource: ArrayDataSource<Author,AuthorCell> {
	override func setup() {
		super.setup()

		tableView.rowHeight = UITableViewAutomaticDimension
		tableView.estimatedRowHeight = 55
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		// setup headerView
		return headerView
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 45
	}
}

class AuthorTableViewController: UIViewController {
	let tableView = UITableView(frame: CGRect.zero, style: .plain)
	var dataSource: AuthorDataSource!

	override func viewDidLoad() {
		super.viewDidLoad()
		let authors: [Author] = [] // APIClass.magicMethodThatGetsAuthors()
		dataSource = AuthorDataSource(tableView: tableView, array: authors)
	}
}


//: [Next](@next)
