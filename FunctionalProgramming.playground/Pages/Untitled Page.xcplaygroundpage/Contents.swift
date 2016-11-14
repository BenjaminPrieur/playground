import Foundation
//import Alamofire

enum RideType {
  case Family
  case Kids
  case Thrill
  case Scary
  case Relaxing
  case Water
}

struct Ride {
  let name: String
  let types: Set<RideType>
  let waitTime: Double
}

let parkRides = [
  Ride(name: "Raging Rapids", types: [.Family, .Thrill, .Water], waitTime: 45.0),
  Ride(name: "Crazy Funhouse", types: [.Family], waitTime: 10.0),
  Ride(name: "Spinning Tea Cups", types: [.Kids], waitTime: 15.0),
  Ride(name: "Spooky Hollow", types: [.Scary], waitTime: 30.0),
  Ride(name: "Thunder Coaster", types: [.Family, .Thrill], waitTime: 60.0),
  Ride(name: "Grand Carousel", types: [.Family, .Kids], waitTime: 15.0),
  Ride(name: "Bumper Boats", types: [.Family, .Water], waitTime: 25.0),
  Ride(name: "Mountain Railroad", types: [.Family, .Relaxing], waitTime: 0.0)
]


// Modularity
func sortedNames(rides: [Ride]) -> [String] {
  var sortedRides = rides
  
  sortedRides = sortedRides.sort { (lhs, rhs) -> Bool in
    return lhs.name.localizedCompare(rhs.name) == .OrderedAscending
  }
  
  return sortedRides.map { $0.name }
}

func waitTimeIsShort(ride: Ride) -> Bool {
  return ride.waitTime < 15.0
}

print(sortedNames(parkRides))

var shortWaitTimeRides = parkRides.filter(waitTimeIsShort)
print(shortWaitTimeRides)


// CURRYING
func rideTypeFilter(type: RideType)(fromRides rides: [Ride]) -> [Ride] {
  return rides.filter { $0.types.contains(type) }
}

func createRideTypeFilter(type: RideType) -> [Ride] -> [Ride] {
  return rideTypeFilter(type)
}


let kidRideFilter = createRideTypeFilter(.Kids)

print(kidRideFilter(parkRides))


// Pure Functions
func ridesWithWaitTimeUnder(waitTime: Double, fromRides rides: [Ride]) -> [Ride] {
  return rides.filter { $0.waitTime < waitTime }
}

var shortWaitRides = ridesWithWaitTimeUnder(15.0, fromRides: parkRides)
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

func quicksort<T: Comparable>(var elements: [T]) -> [T] {
  if elements.count > 1 {
    let pivot = elements.removeAtIndex(0)
    return quicksort(elements.filter { $0 <= pivot }) + [pivot] + quicksort(elements.filter { $0 > pivot })
  }
  return elements
}

print(quicksort(parkRides))
print(parkRides)

var array1: [Ride]? = nil
var array2: [Ride]? = nil

func ==<T: Equatable>(lhs: [T]?, rhs: [T]?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l == r
  case (.None, .None):
    return true
  default:
    return false
  }
}

array1 == array2

//: [Next](@next)