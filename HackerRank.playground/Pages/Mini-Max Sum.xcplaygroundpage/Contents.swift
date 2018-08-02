//: [Previous](@previous)

import Foundation

var  arr = [1, 2, 3, 4, 5]
let sortedArr = arr.sorted(by: <)
let maxItems = sortedArr.count - 1
let min = sortedArr[0...3].reduce(0, +)
let max = sortedArr[maxItems-3...maxItems].reduce(0, +)
print("\(min) \(max)")

//: [Next](@next)
