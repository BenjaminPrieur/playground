import Foundation

public struct QuakeMonitor {
  public var quakeHandler: ((Quake) -> Void)?

  public init() {}

  public func startMonitoring() {
    let endpointURL = URL(
      string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv"
    )!

    Task {
      // skip the header line and iterate each one
      // to extract the magnitude, time, latitude and longitude
      for try await event in endpointURL.lines.dropFirst() {
        let values = event.split(separator: ",")
        let df = ISO8601DateFormatter()
        df.formatOptions.insert(.withFractionalSeconds)
        let quake: Quake
        let timeString = String(values[0])
        do {
          guard let time = df.date(from: timeString) else {
            throw ParsingError.invalidDate
          }
          quake = Quake(
            time: time,
            latitude: Double(values[1]) ?? 0,
            longitude: Double(values[2]) ?? 0,
            magnitude: Double(values[3]) ?? 0
          )
        } catch let err {
          print("Error: \(err.localizedDescription) - \(timeString)")
          continue
        }
        quakeHandler?(quake)
      }
    }
  }

  public func stopMonitoring() {
    print("Stop monitoring")
  }
}
