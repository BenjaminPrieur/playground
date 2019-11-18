//: [Previous](@previous)

import Foundation

// ref: https://www.swiftbysundell.com/articles/defining-custom-patterns-in-swift/

// *********************************************************************
// MARK: - Sample 1
func levelFinished(withScore score: Int) {
    switch score {
    case .lessThan(50):
        print("GameOver")
    case .greaterThan(250):
        print("NewHighscore")
    default:
        print("Go to next level")
    }
}

levelFinished(withScore: 275)

// *********************************************************************
// MARK: - Sample 2
let listItemParser = ListItemParser(kind: .numbered)
do {
    try listItemParser.parseLine("1 test")
} catch let e {
    print(e)
}

// *********************************************************************
// MARK: - Sample 3
struct Destination {
    var address: String
    var city: String
    var country: Country
}

enum Country {
    case france
    var isInEurope: Bool { true }
}

enum ShippingCost {
    case free, reduced, normal
}

extension Destination {
    var shippingCost: ShippingCost {
        switch self {
        // Combining a key path with a constant value:
        case \.city == "Paris":
            return .free
        // Using a nested key path as a pattern:
        case \.country.isInEurope:
            return .reduced
        default:
            return .normal
        }
    }
}

let destination = Destination(address: "YOLO", city: "Paris", country: .france)
print(destination.shippingCost)


//: [Next](@next)
