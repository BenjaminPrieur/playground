//: [Previous](@previous)

import Foundation

let time = "12:05:45AM"
let indexEndOfText = time.index(time.startIndex, offsetBy: time.count - 2)
let meridiem = time[indexEndOfText...]
var splitTime = time[..<indexEndOfText].split(separator: ":").compactMap({ Int($0) })
if meridiem == "PM" && splitTime[0] != 12 {
  var hours = splitTime[0] + 12
  splitTime[0] = hours
} else if meridiem == "AM" && splitTime[0] == 12 {
  splitTime[0] = 0
}
print(splitTime.map({ String(format: "%02d", $0) }).joined(separator: ":"))


//: [Next](@next)
