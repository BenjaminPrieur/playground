import Foundation

public func incr(_ x: Int) -> Int {
	return x + 1
}

public func square(_ x: Int) -> Int {
	return x * x
}

public extension Int {

	public func incr() -> Int {
		return self + 1
	}

	public func square() -> Int {
		return self * self
	}

	func incrAndSquare() -> Int {
		return self.incr().square()
	}

}
