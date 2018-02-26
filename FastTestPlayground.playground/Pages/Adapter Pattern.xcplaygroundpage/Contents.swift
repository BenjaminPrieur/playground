//: [Previous](@previous)

import Foundation

class Tile {
	var id: String
	var type: String
	var title: String?
	var subtitle: String?

	init(id: String, type: String) {
		self.id = id
		self.type = type
	}

	static func createTile(type: String) -> Tile {
		switch type {
		case "program":
			return Program()
		case "season":
			return Season()
		case "person":
			return Person()
		default:
			return Tile(id: "0", type: type)
		}
	}
}

class Program: Tile {
	convenience init() {
		self.init(id: "1", type: "program")
	}
}

class Season: Tile {
	convenience init() {
		self.init(id: "2", type: "season")
	}
}

class Person: Tile {
	convenience init() {
		self.init(id: "3", type: "person")
	}
}

let tiles: [Tile] = [Tile.createTile(type: "program"), Tile.createTile(type: "season"), Tile.createTile(type: "person"), Tile.createTile(type: "custom")]

for tile in tiles {
	print(tile.id)
}

//: [Next](@next)
