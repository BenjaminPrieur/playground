//: [Previous](@previous)

import Foundation

enum SearchError: Error {
	case invalidQuery(String)
	case dataLoadingFailed(URL)
}

func perform<T>(_ expression: @autoclosure () throws -> T,
             orThrow error: Error) throws -> T {
	do {
		return try expression()
	} catch {
		throw error
	}
}

func loadSearchData(matching query: String) throws -> Data {
	let urlString = "https://my.api.com/search?q=\(query)"

	guard let url = URL(string: urlString) else {
		throw SearchError.invalidQuery(query)
	}

	return try perform(Data(contentsOf: url),
	                   orThrow: SearchError.dataLoadingFailed(url))
}

do {
	try loadSearchData(matching: " ")
} catch let error {
	print(error)
}

//: [Next](@next)
