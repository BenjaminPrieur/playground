//: [Previous](@previous)

import Foundation

let v = 4
let arr = [1, 4, 5, 7, 9, 12]

func introTutorial(V: Int, arr: [Int]) -> Int {
  return arr.index(of: V) ?? 0
}

print(introTutorial(V: v, arr: arr))

//: [Next](@next)
