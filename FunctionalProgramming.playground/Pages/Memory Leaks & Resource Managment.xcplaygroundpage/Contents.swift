//: [Previous](@previous)

import Foundation

class Car {
	var plate: String
	var driver: Driver?

	init(plate: String) {
		self.plate = plate
	}
}

class Driver {
	let name: String
	var cars: [Car] = []

	lazy var allPlates: () -> String = { [unowned self] in
		return "Car plates are: "
			+ self.cars.map { $0.plate }.joined(separator: ", ")
	}

	init(name: String) {
		self.name = name
	}
}

var car1: Car? = Car(plate: "ABC123")
var car2: Car? = car1
var car3: Car? = car1

// If you nil one variable out:
car3 = nil
// Now the reference count is down to 2. Now if you do it again:
car1 = nil
// The reference count is down to 1. And one more time:
car2 = nil
// Finally, the reference count is zero and now the system deallocates the instance from memory and frees up that resource space


// *********************************************************************
// MARK: - How Memory Leaks Happen
// *********************************************************************

var myCar: Car? = Car(plate: "ABC123") //Car instance reference count is 1
var myDriver: Driver? = Driver(name: "Neo") //Driver instance reference count is 1

myCar?.driver = myDriver //Driver instance reference count is 2

if let car = myCar {
	myDriver?.cars.append(car) //Car instance reference count is 2
}

myCar = nil //Car instance reference count is 1
myDriver = nil //Driver instance reference count is 1

// This is a strong reference cycle; those instances will never be released from memory and are inaccessible too.


// 1. Resolving Strong Reference Cycles Like It’s 1999!

myCar?.driver = nil
myCar = nil
myDriver = nil

// or

myDriver?.cars.removeAll()
myCar = nil
myDriver = nil


// 2. Resolving Strong Reference Cycles Like a Champ!

//class Car {
//	var plate: String
//	weak var driver: Driver?
//
//	init(plate: String) {
//		self.plate = plate
//	}
//
//	deinit {
//		print("Car deallocated")
//	}
//}
//
//class Driver {
//	let name: String
//	var cars: [Car] = []
//
//	init(name: String) {
//		self.name = name
//	}
//
//	deinit {
//		print("Driver deallocated")
//	}
//}
//
//var myCar: Car? = Car(plate: "ABC123") //Car instance reference count is 1
//var myDriver: Driver? = Driver(name: "Neo") //Driver instance reference count is 1
//
//myCar?.driver = myDriver //Driver instance reference count is STILL 1
//
//if let car = myCar {
//	myDriver?.cars.append(car) //Car instance reference count is 2
//}
//
//myCar = nil //Car instance reference count is 1
//myDriver = nil //Driver instance reference count is zero, also car instance reference count is ze


// 3. Resolving Strong Reference Cycles Like a Jedi!

//struct Car {
//	var plate: String
//	var driver: Driver?
//
//	init(plate: String) {
//		self.plate = plate
//	}
//}
//
//struct Driver {
//	let name: String
//	var cars: [Car] = []
//
//	lazy var allPlates: () -> String = {
//		return "Car plates are: "
//			+ self.cars.map{ $0.plate }.joinWithSeparator(", ")
//	}
//
//	init(name: String) {
//		self.name = name
//	}
//}

//var myCar: Car? = Car(plate: "ABC123") //Car instance reference count is 1
//var myDriver: Driver? = Driver(name: "Neo") //Driver instance reference count is 1
//
//myCar?.driver = myDriver //Driver instance is COPIED, so reference count is 1
//
//if let car = myCar {
//	myDriver?.cars.append(car) //Car instance is COPIED, so reference count is 1
//}
//
//myCar = nil //Car instance deallocated
//myDriver?.cars[0] //Car instance still lives on, it's a copy!
//myDriver = nil //Driver instance deallocated



//: [Next](@next)
