import Foundation

enum RideType {
  case family
  case kids
  case thrill
  case scary
  case relaxing
  case water
}

struct Ride {
  let name: String
  let types: Set<RideType>
  let waitTime: Double
}

let parkRides = [
  Ride(name: "Raging Rapids", types: [.family, .thrill, .water], waitTime: 45.0),
  Ride(name: "Crazy Funhouse", types: [.family], waitTime: 10.0),
  Ride(name: "Spinning Tea Cups", types: [.kids], waitTime: 15.0),
  Ride(name: "Spooky Hollow", types: [.scary], waitTime: 30.0),
  Ride(name: "Thunder Coaster", types: [.family, .thrill], waitTime: 60.0),
  Ride(name: "Grand Carousel", types: [.family, .kids], waitTime: 15.0),
  Ride(name: "Bumper Boats", types: [.family, .water], waitTime: 25.0),
  Ride(name: "Mountain Railroad", types: [.family, .relaxing], waitTime: 0.0)
]


// Modularity
func sortedNames(rides: [Ride]) -> [String] {
  var sortedRides = rides
  
  sortedRides = sortedRides.sorted { (lhs, rhs) -> Bool in
    return lhs.name.localizedCompare(rhs.name) == .orderedAscending
  }
  
  return sortedRides.map { $0.name }
}

func waitTimeIsShort(ride: Ride) -> Bool {
  return ride.waitTime < 15.0
}

print(sortedNames(rides: parkRides))

var shortWaitTimeRides = parkRides.filter(waitTimeIsShort)
print(shortWaitTimeRides)


// CURRYING
func rideTypeFilter(type: RideType) -> ([Ride]) -> [Ride] {
  return { rides -> [Ride] in
    return rides.filter { $0.types.contains(type) }
  }
}

func createRideTypeFilter(type: RideType) -> ([Ride]) -> [Ride] {
  return rideTypeFilter(type: type)
}


let kidRideFilter = createRideTypeFilter(type: .kids)

print(kidRideFilter(parkRides))


// Pure Functions
func ridesWithWaitTimeUnder(waitTime: Double, fromRides rides: [Ride]) -> [Ride] {
  return rides.filter { $0.waitTime < waitTime }
}

var shortWaitRides = ridesWithWaitTimeUnder(waitTime: 15.0, fromRides: parkRides)
assert(shortWaitRides.count == 2, "Count of short wait rides should be 2")
print(shortWaitRides)


// Recursion
extension Ride: Comparable { }

func <(lhs: Ride, rhs: Ride) -> Bool {
  return lhs.waitTime < rhs.waitTime
}

func ==(lhs: Ride, rhs: Ride) -> Bool {
  return lhs.name == rhs.name
}

func quicksort<T: Comparable>(elements: [T]) -> [T] {
  var elements = elements
  if elements.count > 1 {
    let pivot = elements.remove(at: 0)
    let before = quicksort(elements: elements.filter { $0 <= pivot } )
    let after = quicksort(elements: elements.filter { $0 > pivot } )
    return before + [pivot] + after
  }
  return elements
}

print(quicksort(elements: parkRides))
print(parkRides)

var array1: [Ride]? = nil
var array2: [Ride]? = nil

func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l == r
  case (.none, .none):
    return true
  default:
    return false
  }
}

array1 == array2

//: [Next](@next)
