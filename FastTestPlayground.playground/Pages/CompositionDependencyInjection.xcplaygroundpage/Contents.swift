//: [Previous](@previous)

import Foundation

// http://merowing.info/2017/04/using-protocol-compositon-for-dependency-injection/

class HomeManager {
	var result: String = "Test"
}
class LikeManager {}

protocol HasHomeManager {
	var homeManager: HomeManager { get }
}

protocol HasLikeManager {
	var likeManager: LikeManager { get }
}

struct AppDependency: HasHomeManager, HasLikeManager {
	let homeManager: HomeManager
	let likeManager: LikeManager
}

class FooViewModel {
	typealias Dependencies = HasHomeManager & HasLikeManager

	let dependencies: Dependencies

	init(dependencies: Dependencies) {
		self.dependencies = dependencies
		print(dependencies.homeManager.result)
	}
}

let appDependency = AppDependency(homeManager: HomeManager(), likeManager: LikeManager())
var fooViewModel = FooViewModel(dependencies: appDependency)

//: [Next](@next)
