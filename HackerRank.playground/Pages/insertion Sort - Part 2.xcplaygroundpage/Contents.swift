//: [Previous](@previous)

import Foundation

let arr = [1, 4, 3, 5, 6, 2, -1]
var result = arr
for index in 1..<arr.count {
  let item = arr[index]
  var newIndex = index
  while newIndex > 0, item < result[newIndex - 1] {
    result[newIndex] = result[newIndex - 1]
    newIndex -= 1
  }
  result[newIndex] = item
  print(result.map({ "\($0)" }).joined(separator: " "))
}

//: [Next](@next)
