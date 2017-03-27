//: [Previous](@previous)

import Foundation
import XCTest

// *********************************************************************
// MARK: - NetworkEngine Protocol
protocol NetworkEngine {
	typealias Handler = (Data?, URLResponse?, Error?) -> Void
	func performRequest(for url: URL, completionHandler: @escaping Handler)
}

extension URLSession: NetworkEngine {

	typealias Handler = NetworkEngine.Handler

	func performRequest(for url: URL, completionHandler: @escaping Handler) {

		let task = dataTask(with: url, completionHandler: completionHandler)
		task.resume()
	}

}

// *********************************************************************
// MARK: - Class
class DataLoader {

	enum Result {
		case data(Data)
		case error(Error)
	}

	private let engine: NetworkEngine

	init(engine: NetworkEngine = URLSession.shared) {
		self.engine = engine
	}

	func load(from url: URL, completionHandler: @escaping (Result) -> Void) {

		engine.performRequest(for: url) { (data, response, error) in
			if let error = error {
				return completionHandler(.error(error))
			}
			completionHandler(.data(data ?? Data()))
		}

	}
}

// *********************************************************************
// MARK: - Unit Test

func testLoadingData() {
	class NetworkEngineMock: NetworkEngine {
		typealias Handler = NetworkEngine.Handler

		var requestedURL: URL?
		func performRequest(for url: URL, completionHandler: @escaping Handler) {

			requestedURL = url
			let data = "Hello world".data(using: .utf8)
			completionHandler(data, nil, nil)
		}

	}

	let engine = NetworkEngineMock()
	let loader = DataLoader(engine: engine)
	var result: DataLoader.Result?
	let url = URL(string: "my/API")!
	loader.load(from: url) { result = $0 }
	XCTAssertEqual(engine.requestedURL, url)
//	XCTAssertEqual(result, .data("Hello world".data(using: .utf8)!))
}

//: [Next](@next)
