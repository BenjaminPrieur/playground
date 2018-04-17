import Foundation

public extension Equatable {
	func isAny(of candidates: Self...) -> Bool {
		return candidates.contains(self)
	}
}

//let isHorizontal = direction.isAny(of: .left, .right)

