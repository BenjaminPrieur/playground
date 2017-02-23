//: [Previous](@previous)

import Foundation

protocol Requestable {
	associatedtype Model
	func test(_ obj: Model)
}

class TestService: Requestable {
	typealias Model = String

	func test(_ obj: String) {
		print(obj)
	}
}

class Manager<T: Requestable> {
	var demo: T

	init(service: T) {
		demo = service
	}
}

Manager(service: TestService())


public func getPersonID() -> String? {

	let queryItems = [URLQueryItem(name: "id", value: "3"), URLQueryItem(name: "program_id", value: "4")]

	guard let value = getValueForItems(name: "id", inQuery: queryItems) else {
		return nil
	}

	return value
}

public func getValueForItems(name: String, inQuery queryItems: [URLQueryItem]) -> String? {

	guard let typeItem = queryItems.filter({ $0.name == name }).first, let value = typeItem.value else {
		return nil
	}

	return value
}

//: [Next](@next)
