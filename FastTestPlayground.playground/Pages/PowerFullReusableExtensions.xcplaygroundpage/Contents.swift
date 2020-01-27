//: [Previous](@previous)

import Foundation

let user = User(id: "benp", name: "ben p")
//try? user.cacheOnDisk()
print(user.id)
try? Container().write(user.id.rawValue)
var str = "Hello, playground"

//: [Next](@next)
