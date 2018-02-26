//: [Previous](@previous)

import Foundation

enum MyScreenModel {
	case empty
	case loading
	case data(Data)
	case failed(Error)
}

extension MyScreenModel {
	var isLoading: Bool {
		guard case .loading = self else { return false }
		return true
	}

	var isEmpty: Bool {
		guard case .empty = self else { return false }
		return true
	}
	var data: Data? {
		guard case let .data(someInfo) = self else { return nil }
		return someInfo
	}
	var error: Error? {
		guard case let .failed(error) = self else { return nil }
		return error
	}
}

//: [Next](@next)
