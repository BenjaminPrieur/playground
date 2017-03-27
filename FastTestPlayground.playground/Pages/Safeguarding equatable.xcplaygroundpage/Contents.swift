//: [Previous](@previous)

import Foundation
import UIKit

/**
Asserts that two expressions have the same `dump` output.

- Note: The assertion is only active when the `DEBUG`
conditional compilation flag is defined). Otherwise the
function does nothing. Note that playgrounds and -Onone
builds don't automatically set the `DEBUG` flag.
*/

func assertDumpsEqual<T>(_ lhs: @escaping () -> T,
                      _ rhs: @escaping () -> T,
                      file: StaticString = #file, line: UInt = #line) {
	func areDumpsEqual() -> Bool {
		var left = "", right = ""
		// Error: Declaration closing over non-escaping
		// parameter may allow it to escape
		dump(lhs(), to: &left)
		// Error: Declaration closing over non-escaping
		// parameter may allow it to escape
		dump(rhs(), to: &right)
		return left == right
	}
	assert(areDumpsEqual(), "Expected dumps to be equal.",
	       file: file, line: line)
}

/// - Note: Requires Swift 3.1 for `withoutActuallyEscaping`.
//func assertDumpsEqual<T>(_ lhs: @autoclosure () -> T,
//                      _ rhs: @autoclosure () -> T,
//                      file: StaticString = #file, line: UInt = #line) {
//
//	// Nested function is a workaround for SR-4188: `withoutActuallyEscaping`
//	// doesn't accept `@autoclosure` argument. https://bugs.swift.org/browse/SR-4188
//	func assertDumpsEqualImpl(lhs: () -> T, rhs: () -> T) {
//		withoutActuallyEscaping(lhs) { escapableL in
//			withoutActuallyEscaping(rhs) { escapableR in
//				func areDumpsEqual() -> Bool {
//					var left = "", right = ""
//					dump(escapableL(), to: &left)
//					dump(escapableR(), to: &right)
//					return left == right
//				}
//				assert(areDumpsEqual(), "Expected dumps to be equal.",
//				       file: file, line: line)
//			}
//		}
//	}
//	assertDumpsEqualImpl(lhs: lhs, rhs: rhs)
//}


dump([1,2,3])
// ▿ 3 elements
//   - 1
//   - 2
//   - 3
dump(1..<10)
// ▿ CountableRange(1..<10)
//   - lowerBound: 1
//   - upperBound: 10
dump(["key": "value"])
// ▿ 1 key/value pair
//   ▿ (2 elements)
//     - .0: "key"
//     - .1: "value"
dump("Lisa" as String?)
// ▿ Optional("Lisa")
//   - some: "Lisa"
dump(Date())
// ▿ 2017-03-08 14:08:27 +0000
//   - timeIntervalSinceReferenceDate: 510674907.82620001
dump([1,2,3] as NSArray)
// ▿ 3 elements #0
//   - 1 #1
//     - super: NSNumber
//       - super: NSValue
//         - super: NSObject
//   - 2 #2
//     - super: NSNumber
//       - super: NSValue
//         - super: NSObject
//   - 3 #3
//     - super: NSNumber
//       - super: NSValue
//         - super: NSObject
dump("Hello" as NSString)
// - Hello #0
//   - super: NSMutableString
//     - super: NSString
//       - super: NSObject
dump(UIColor.red)
// - UIExtendedSRGBColorSpace 1 0 0 1 #0
//   - super: UIDeviceRGBColor
//     - super: UIColor
//       - super: NSObject

// Dumps of UIFont objects _do_ include a memory address,
// but UIFont shares these objects internally, so this is
// not a problem.
let f1 = UIFont(name: "Helvetica", size: 12)!
let f2 = UIFont(name: "Helvetica", size: 12)!
f1 == f2 // → true
dump(f1)
// - <UICTFont: 0x7ff5e6102e60> font-family: "Helvetica"; font-weight: normal; font-style: normal; font-size: 12.00pt #0
//   - super: UIFont
//     - super: NSObject
dump(f2)
// - <UICTFont: 0x7ff5e6102e60> font-family: "Helvetica"; font-weight: normal; font-style: normal; font-size: 12.00pt #0
//   - super: UIFont
//     - super: NSObject

// Dumps of Swift classes _do not_ include a memory
// address:
class A {
	let value: Int
	init(value: Int) { self.value = value }
}
dump(A(value: 42))
// ▿ A #0
//   - value: 42

// NSObject subclasses _do_ include a memory address
// and hence are problematic:
class B: NSObject {
	let value: Int
	init(value: Int) {
		self.value = value
		super.init()
	}
	static func ==(lhs: B, rhs: B) -> Bool {
		return lhs.value == rhs.value
	}
}
dump(B(value: 42))
// ▿ <__lldb_expr_26.B: 0x101012160> #0
//   - super: NSObject
//   - value: 42

// Fix: override `description`:
extension B {
	override open var description: String {
		return "B: \(value)"
	}
}
dump(B(value: 42))
// ▿ B: 42 #0
//   - super: NSObject
//   - value: 42


//: [Next](@next)
