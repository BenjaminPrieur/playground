//: [Previous](@previous)

import Foundation
import _Concurrency

// Create a Timer async stream.
let stream = Timer
  .publish(every: 1.0, tolerance: 1.0, on: .main, in: .common)
  .autoconnect()
  .asyncStream()

// Cancel stream after 5 seconds.
Task.detached {
  await Task.sleep(5_000_000_000)
  stream.cancel()
}

// Print timer ticks to the console.
for try await tick in stream {
  print("\(tick.formatted(date: .omitted, time: .standard))")
}

// Print when the for loop completes
print("Completed.")

//: [Next](@next)
