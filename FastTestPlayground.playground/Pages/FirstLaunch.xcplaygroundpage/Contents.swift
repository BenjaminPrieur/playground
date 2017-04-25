//: [Previous](@previous)

import Foundation

final class FirstLaunch {

	let wasLaunchedBefore: Bool
	var isFirstLaunch: Bool {
		return !wasLaunchedBefore
	}

	init(getWasLaunchedBefore: () -> Bool,
	     setWasLaunchedBefore: (Bool) -> ()) {
		let wasLaunchedBefore = getWasLaunchedBefore()
		self.wasLaunchedBefore = wasLaunchedBefore
		if !wasLaunchedBefore {
			setWasLaunchedBefore(true)
		}
	}

	convenience init(userDefaults: UserDefaults, key: String) {
		self.init(getWasLaunchedBefore: { userDefaults.bool(forKey: key) },
		          setWasLaunchedBefore: { userDefaults.set($0, forKey: key) })
	}

}

let firstLaunch = FirstLaunch(userDefaults: .standard, key: "com.any-suggestion.FirstLaunch.WasLaunchedBefore")
if firstLaunch.isFirstLaunch {
	// do things
}

let alwaysFirstLaunch = FirstLaunch(getWasLaunchedBefore: { return false }, setWasLaunchedBefore: { _ in })
if alwaysFirstLaunch.isFirstLaunch {
	// will always execute
}

extension FirstLaunch {

	static func alwaysFirst() -> FirstLaunch {
		return FirstLaunch(getWasLaunchedBefore: { return false }, setWasLaunchedBefore: { _ in })
	}

}

let alwaysFirstLaunch2 = FirstLaunch.alwaysFirst()
if alwaysFirstLaunch2.isFirstLaunch {
	// will always execute
}

//: [Next](@next)
