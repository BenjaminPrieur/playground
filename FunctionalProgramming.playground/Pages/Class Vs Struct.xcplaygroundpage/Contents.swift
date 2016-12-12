//: [Previous](@previous)

import Foundation

class TestClass: Equatable {
  var string = "Coucou"
}

func == (lsh: TestClass, rhs: TestClass) -> Bool {
  return lsh.string == rhs.string
}

var a = TestClass()
let w = TestClass()
var b = a
a.string = "top"
b.string = "super"
print(b == a)

struct TestStruct {
  var string = "coucouc"
}

func == (lsh: TestStruct, rhs: TestStruct) -> Bool {
  return lsh.string == rhs.string
}

var c = TestStruct()
var d = c
c.string = "salut"
print(c == d)
d = c
print(c == d)

let gregorian: NSCalendar = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)!
let currentDate: NSDate = NSDate()
let components: NSDateComponents = NSDateComponents()
components.year = -16
let maxDate: NSDate = gregorian.date(byAdding: components as DateComponents, to: currentDate as Date, options: NSCalendar.Options.wrapComponents)! as NSDate

print(NSCalendar.Options.wrapComponents)

//: [Next](@next)
