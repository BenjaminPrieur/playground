//: [Previous](@previous)

import Foundation

struct Registration<T> {
	let object: T
	let endDate: Date
}

class Cache<T> {

	private let dateGenerator: () -> Date
	private var registrations = [String: Registration<T>]()

	init(dateGenerator: @escaping () -> Date = Date.init) {
		self.dateGenerator = dateGenerator
	}

	func cache(_ object: T, forKey key: String) {
		let currentDate = dateGenerator()
		let endDate = currentDate.addingTimeInterval(60 * 60 * 24)
		registrations[key] = Registration(object: object, endDate: endDate)
	}

	func object(forKey key: String) -> T? {
		guard let registration = registrations[key] else {
			return nil
		}

		let currentDate = dateGenerator()

		guard registration.endDate >= currentDate else {
			registrations[key] = nil
			return nil
		}

		return registration.object
	}
}

class TimeTraveler {
	private var date = Date()

	func travel(by timeInterval: TimeInterval) {
		date = date.addingTimeInterval(timeInterval)
	}

	func generateDate() -> Date {
		return date
	}
}

class Object {}

// *********************************************************************
// MARK: - Test

let timeTraveler = TimeTraveler()
let cache = Cache<Object>(dateGenerator: timeTraveler.generateDate)
let object = Object()

cache.cache(object, forKey: "key")
// Must return object
print(cache.object(forKey: "key"))

timeTraveler.travel(by: 60 * 60 * 24 * 2)
// Must be nil
print(cache.object(forKey: "key"))

//: [Next](@next)
