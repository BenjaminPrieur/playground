//: [Previous](@previous)

import Foundation

// https://marcosantadev.com/swift-arrays-holding-elements-weak-references/

extension NSPointerArray {
	func addObject(_ object: AnyObject?) {
		guard let strongObject = object else { return }

		let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
		addPointer(pointer)
	}

	func insertObject(_ object: AnyObject?, at index: Int) {
		guard index < count, let strongObject = object else { return }

		let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
		insertPointer(pointer, at: index)
	}

	func replaceObject(at index: Int, withObject object: AnyObject?) {
		guard index < count, let strongObject = object else { return }

		let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
		replacePointer(at: index, withPointer: pointer)
	}

	func object(at index: Int) -> AnyObject? {
		guard index < count, let pointer = self.pointer(at: index) else { return nil }
		return Unmanaged<AnyObject>.fromOpaque(pointer).takeUnretainedValue()
	}

	func removeObject(at index: Int) {
		guard index < count else { return }

		removePointer(at: index)
	}
}


class MyClass {}
var array = NSPointerArray.weakObjects()

let obj = MyClass()
array.addObject(obj)

// If you want to clean the array removing the objects with value nil, you can call the method compact():
array.compact()


// *********************************************************************
// MARK: - Other solution

class WeakRef<T> where T: AnyObject {

	private(set) weak var value: T?

	init(value: T?) {
		self.value = value
	}
}

class View { }

class Drawer {

	private var views: [WeakRef<View>]

	init(views: [WeakRef<View>]) {
		self.views = views
	}

	func draw() {
	}

	func compact() {
		views = views.filter { $0.value != nil }
	}
}

//: [Next](@next)
