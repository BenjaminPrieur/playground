//: [Previous](@previous)

import Foundation

let grades: [Int] = [73, 67, 38, 33]

let result = grades.map { grade -> Int in
  let diffToBeRounded = abs(grade % 5 - 5)
  let canBeRounded = diffToBeRounded < 3
  if canBeRounded, grade > 38 {
    return grade + diffToBeRounded
  } else {
    return grade
  }
}

print(result)

var str = "Hello, playground"

//: [Next](@next)
