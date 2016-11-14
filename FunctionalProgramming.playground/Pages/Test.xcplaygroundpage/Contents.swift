//: [Previous](@previous)

import Foundation

func calculate(a: Int, _ b: Int, _ operation: (Int, Int) -> Int) -> Int {
  return operation(a, b)
}

func plus(a: Int, _ b: Int) -> Int {
  return a + b
}

func multiply(a: Int, _ b: Int) -> Int {
  return a * b
}

print(calculate(3, 7, plus))
// > 10
print(calculate(3, 7, multiply))
// > 21

func showMessage(message: String, _ operation: (String) -> Void) {
  return operation(message)
}

func showPrintedMessage(message: String) {
  print(message)
}

showMessage("coucou", showPrintedMessage)
showMessage("coucou2", showPrintedMessage)


enum UserError: ErrorType { case NoData, ParsingError }
struct User {
  init(fromData: NSData) throws {
    throw UserError.ParsingError
  }
}

typealias UserBuilder = Void throws -> Void
typealias CompletionVoidThrows = Void throws -> Void

func fetchUser(completion: CompletionVoidThrows -> Void) {

  completion({ UserBuilder in
    let dataBrute: NSData? = NSData()
    guard let data = dataBrute else { throw UserError.NoData }
    try User(fromData: data)
  })

}

fetchUser { (userBuilder: CompletionVoidThrows) in
  do {
    try userBuilder()
    print("Done")
  } catch {
    print("Async error while fetching User: \(error)")
  }
}


enum Jailbroken {
  case isJailbroken
  case isNotJailbroken
}

//: [Next](@next)
