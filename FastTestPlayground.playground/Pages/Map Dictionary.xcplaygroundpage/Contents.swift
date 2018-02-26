//: [Previous](@previous)

import Foundation

extension Dictionary {
	func map<K: Hashable, V>(_ transform: (Element) throws -> (key: K, value: V)) rethrows -> [K : V] {
		var transformed = [K : V]()

		for pair in self {
			let transformedPair = try transform(pair)
			transformed[transformedPair.key] = transformedPair.value
		}

		return transformed
	}
}

let dictionary = [
	"hello": 1,
	"world": 2
]

let transformed = dictionary.map { pair in
	return (pair.key, Double(pair.value))
}

//: [Next](@next)
