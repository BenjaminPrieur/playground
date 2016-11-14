//: [Previous](@previous)

import Foundation

/// ---------------
/// Framework.swift

public protocol Pingable { func ping() -> Self }
public protocol Playable { func play() }

extension Int : Pingable {
    public func ping() -> Int { return self + 1 }
}

//public class Game<T : Pingable> : Playable {
//    var t : T
//
//    public init (_ v : T) {t = v}
//
//    @_specialize(Int)
//    public func play() {
//        for _ in 0...100_000 { t = t.ping() }
//    }
//}
//
///// -----------------
///// Application.swift
//
//Game(10).play()

//: [Next](@next)
