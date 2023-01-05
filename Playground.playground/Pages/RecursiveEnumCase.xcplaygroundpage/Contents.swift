//: [Previous](@previous)
import Foundation

struct Script: Equatable {}

// Indirect enums are able to reference themselves, enabling
// us to set up recursive data structures.
indirect enum Content: Equatable {
  case values([String: String])
  case script(Script)
  case collection(Content)
}

extension Content {
  // Using static functions, we can create "fake" enum cases,
  // that can act as convenience APIs — without having to add
  // additional case handling code in our switch statements.
  static func text(_ text: String) -> Content {
    return .values(["content": text])
  }
}

let content: Content = .text("test")
let recursiveCase: Content = .collection(.collection(.text("test")))

func print(_ content: Content, deepLevel: Int = 0) {
  switch content {
  case .text("test"):
    print("matching case at level: \(deepLevel)")
  case let .collection(content):
    print("recursive case \(deepLevel)")
    print(content, deepLevel: deepLevel + 1)
  default:
    print("default case")
  }
}

print(content)
print(recursiveCase)

//: [Next](@next)
