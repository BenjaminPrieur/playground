//: [Previous](@previous)

import Foundation

//let arr = [2, 4, 6, 8, 3, -10000]
let arr = [1, 4, 3, 5, 6, 2]
var result = arr
var lastMax = Int.min
print(result.map({ "\($0)" }).joined(separator: " "))
for (index, value) in arr.enumerated() {
  if value < lastMax, index != 0 {
    var newIndex = index
    while newIndex > 0 && result[newIndex - 1] > value {
      result[newIndex] = result[newIndex - 1]
      newIndex -= 1
    }
    result[newIndex] = value
    print(result.map({ "\($0)" }).joined(separator: " "))
  } else {
    lastMax = value
  }
}
print(result.map({ "\($0)" }).joined(separator: " "))

//: [Next](@next)
