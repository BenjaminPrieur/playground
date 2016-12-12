//: [Previous](@previous)

import Foundation

struct Sports: OptionSet {
	let rawValue: Int

	static let running = Sports(rawValue: 1)
	static let cycling = Sports(rawValue: 2)
	static let swimming = Sports(rawValue: 4)
	static let fencing = Sports(rawValue: 8)
	static let shooting = Sports(rawValue: 32)
	static let horseJumping = Sports(rawValue: 512)
}

let triathlon: Sports = [.swimming, .cycling, .running]
triathlon.contains(.swimming)  // → true
triathlon.contains(.fencing)   // → false

extension Sports {
	static let modernPentathlon: Sports =
		[.swimming, .fencing, .horseJumping, .shooting, .running]
}

let commonEvents = triathlon.intersection(.modernPentathlon)
commonEvents.contains(.swimming)    // → true
commonEvents.contains(.cycling)     // → false

//: [Next](@next)
