import Foundation

public struct Quake: CustomStringConvertible {
  public let time: Date
  public let latitude: Double
  public let longitude: Double
  public let magnitude: Double

  public init(time: Date, latitude: Double, longitude: Double, magnitude: Double) {
    self.time = time
    self.latitude = latitude
    self.longitude = longitude
    self.magnitude = magnitude
  }

  public var description: String {
    "Magnitude: \(magnitude) on \(time) at \(latitude) \(longitude)"
  }
}
