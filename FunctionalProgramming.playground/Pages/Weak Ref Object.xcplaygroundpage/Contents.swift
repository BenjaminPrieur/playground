//: [Previous](@previous)

import Foundation

class Weak<T: AnyObject> {
  weak var value : T?
  init (value: T) {
    self.value = value
  }
}

extension Array where Element:Weak<AnyObject> {
  mutating func reap () {
    self = self.filter { nil != $0.value }
  }
}

class Stuff {}
var weakly : [Weak<Stuff>] = [Weak(value: Stuff()), Weak(value: Stuff())]

//: [Next](@next)
