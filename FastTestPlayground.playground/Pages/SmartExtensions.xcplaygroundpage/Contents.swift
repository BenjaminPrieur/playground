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
