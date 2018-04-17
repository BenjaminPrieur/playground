import Foundation

struct Level {
	var score: Int
}

struct Game {
	var levels: [Level]
}

extension Game {
	func calculateTotalScore() -> Int {
		return levels.sum { $0.score }
	}
}

var score = [5, 10, 15, 3]
var levels = score.map(Level.init)
var game = Game(levels: levels)
print(game.calculateTotalScore())

enum Direction {
	case left, right, top, bot
}

let direction = Direction.left
let isHorizontal = direction.isAny(of: .left, .right)
