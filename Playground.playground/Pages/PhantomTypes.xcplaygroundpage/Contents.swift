//: [Previous](@previous)

import Foundation

enum Distance {
    case mile
    case meter
}

enum Mass {
    case pound
    case gram
    case ounce
}

struct Statistics<Unit> {
    let value: Double
}


extension Statistics where Unit == Mass {
    func convert(to unit: Mass) -> Double {
      // missing convertion implementation
      return value
    }
}

extension Statistics where Unit == Distance {
    func convert(to unit: Distance) -> Double {
      // missing convertion implementation
      return value
    }
}

let weight = Statistics<Mass>(value: 75)
// Error: Cannot convert value of type 'Distance' to expected argument type 'Mass'
//weight.convert(to: Distance.meter)
weight.convert(to: .gram)
weight.convert(to: .pound)

//: [Next](@next)
