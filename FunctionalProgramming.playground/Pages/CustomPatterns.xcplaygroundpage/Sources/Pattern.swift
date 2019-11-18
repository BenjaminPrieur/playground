import Foundation

// *********************************************************************
// MARK: - Pattern

public struct Pattern<Value> {
    public let closure: (Value) -> Bool
}

public extension Pattern where Value: Hashable {
    static func any(of candidates: Set<Value>) -> Pattern {
        Pattern { candidates.contains($0) }
    }
}

public func ~=<T>(lhs: Pattern<T>, rhs: T) -> Bool {
    lhs.closure(rhs)
}

public func ~=<T>(lhs: KeyPath<T, Bool>, rhs: T?) -> Bool {
    rhs?[keyPath: lhs] ?? false
}

public extension Pattern where Value: Comparable {
    static func lessThan(_ value: Value) -> Pattern {
        Pattern { $0 < value }
    }

    static func greaterThan(_ value: Value) -> Pattern {
        Pattern { $0 > value }
    }
}

public func ==<T, V: Equatable>(lhs: KeyPath<T, V>, rhs: V) -> Pattern<T> {
    return Pattern { $0[keyPath: lhs] == rhs }
}
