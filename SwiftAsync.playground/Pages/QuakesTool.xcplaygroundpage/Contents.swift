//: [Previous](@previous)

import Foundation
import _Concurrency

let quakes = AsyncStream(Quake.self) { continuation in
  var monitor = QuakeMonitor()
  monitor.quakeHandler = { quake in
    continuation.yield(quake)
  }
  continuation.onTermination = { [monitor] _ in
    monitor.stopMonitoring()
  }
  monitor.startMonitoring()
}

let significantQukes = quakes.filter { quake in
  quake.magnitude > 3
}

Task {
  for await quake in significantQukes {
    print(quake)
  }
}

//: [Next](@next)
