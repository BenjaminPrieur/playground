//: [Previous](@previous)

import Foundation

// https://realm.io/news/try-swift-soroush-khanlou-sequence-collection/

indirect enum LinkedListNode<T> {
	case value(element: T, next: LinkedListNode<T>)
	case end
}

extension LinkedListNode: Sequence {
	func makeIterator() -> LinkedListIterator<T> {
		return LinkedListIterator(current: self)
	}
}

struct LinkedListIterator<T>: IteratorProtocol {

	var current: LinkedListNode<T>

	mutating func next() -> T? {
		switch current {
		case let .value(element: element, next: next):
			current = next
			return element

		case .end:
			return nil

		}
	}
}

extension Sequence {

	func count(_ shouldCount: (Iterator.Element) -> Bool) -> Int {

		var count = 0
		for elememnt in self {
			if shouldCount(elememnt) {
				count += 1
			}
		}

		return count
	}
}

extension Sequence
	where Self.SubSequence: Sequence,
	Self.SubSequence.Iterator.Element == Self.Iterator.Element {

	func eachPair() -> AnySequence<(Iterator.Element, Iterator.Element)> {
		return AnySequence(zip(self, self.dropFirst()))
	}
}

struct APIError {}

struct APIErrorCollection {
	fileprivate let _errors: [APIError]
}

extension APIErrorCollection: Collection {
	var startIndex: Int {
		return _errors.startIndex
	}
	var endIndex: Int {
		return _errors.endIndex
	}
	func index(after i: Int) -> Int {
		return _errors.index(after: i)
	}
	subscript(position: Int) -> APIError {
		return _errors[position]
	}
}

//: [Next](@next)
