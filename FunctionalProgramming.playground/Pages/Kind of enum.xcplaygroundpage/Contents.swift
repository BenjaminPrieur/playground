//: [Previous](@previous)

import Foundation

enum Result<T> {
	case success(T)
	case failure(Error)
}

enum LoadingState<Wrapped> {
	case initial
	case loading
	case loaded(Wrapped)
	case error(Error)
}

//: [Next](@next)
