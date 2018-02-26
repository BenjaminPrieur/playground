//: [Previous](@previous)

import Foundation

protocol TilePrototype {
	var id: String { get }
	var type: String { get }
}

class Tile: TilePrototype {
	var id: String = "1"
	var type: String = "tile"
}

class Program: TilePrototype {
	var id: String = "2"
	var type: String = "program"
}

class Season: TilePrototype {
	var id: String = "3"
	var type: String = "season"
}

class TileDecorator: TilePrototype {

	let tileInstance: TilePrototype

	required init(tile: TilePrototype) {
		self.tileInstance = tile
	}

	var id: String {
		return tileInstance.id
	}

	var type: String {
		return tileInstance.type
	}
}



//: [Next](@next)
