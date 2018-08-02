//: [Previous](@previous)

import Foundation

var arr = [3, 2, 1, 3]
typealias Candle = (count: Int, height: Int)
let initalCandle = Candle(count: 0, height: 0)
let result = arr.reduce(initalCandle) { (lastOne, newOne) -> Candle in
  if lastOne.height == newOne {
    return Candle(count: lastOne.count + 1, lastOne.height)
  } else if lastOne.height < newOne {
    return Candle(count: 1, newOne)
  } else {
    return lastOne
  }
}
print(result.count)

//: [Next](@next)
