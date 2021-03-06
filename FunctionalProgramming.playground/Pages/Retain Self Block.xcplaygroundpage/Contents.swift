//: [Previous](@previous)

import Foundation

func toBool(x: Int) -> Bool {
  precondition(x == 0 || x == 1, "This function can only convert 0 or 1 to Bool")
  if x == 0 {
    return false
  }
  /* x == 1 */
  return true
}

//toBool(3)


class Test: NSObject {
  var testInt: Int!

  override init() {
    super.init()
    precondition(testInt != nil, "test")
  }
}

//let test = Test()

///////////////////////////////////////////////////////////////

/**
* See https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html
*/

import Foundation

protocol DoesSomething {
  func doSomething()
}

/**
 * Capturing properties of self in a closure without referencing self will not compile
 */
class CompilerWarning : DoesSomething {
  var message = "Will not compile"

  func doSomething() {
    let _ = {
       print(self.message) // Error message: Instance member 'message' cannot be used on type 'CompilerWarning'
    }
  }

  deinit {
    print("DEALLOCATED")
  }
}


/**
 * The closure captures self and is assigned to self creating a retain loop
 */
class MemoryLeak1 : DoesSomething {
  var message = "will not deinit"
  var closure: (() -> Void)!

  func doSomething() {
    closure = {
      print(self.message)
    }
    closure()
  }

  deinit {
    print("DEALLOCATED") // Not called
  }
}

/**
 * The nested function is a closure in disguise, it captures self and is them assigned to self via the anonymous closure, creating a retain loop.
 */
class MemoryLeak2 : DoesSomething {
  var message = "will not deinit"
  var closure: (() -> Void)!

  func doSomething() {
    func doSomethingElse() {
      print(self.message)
    }
    closure = {
      doSomethingElse()
    }
    closure()
  }

  deinit {
    print("DEALLOCATED") // Not called
  }
}


/**
 * A fix to the example above, self is captured as a weak reference and no retain cycle is made.
 */
class SafeNestedFunctionWeakVar : DoesSomething {
  var message = "will not deinit"
  var closure: (() -> Void)!

  func doSomething() {
    weak var weakSelf = self
    func doSomethingElse() {
      print(weakSelf!.message)
    }
    closure = {
      doSomethingElse()
    }
    closure()
  }

  deinit {
    print("DEALLOCATED")
  }
}


/**
 * An assigned closure with weak self does not create a retain loop.
 */
class WeakSelfClosure : DoesSomething {
  var message = "will deinit"
  var closure: (() -> Void)!

  func doSomething() {
    closure = { [weak self] in
      print(self?.message)
    }
    closure()
  }

  deinit {
    print("DEALLOCATED")
  }
}

/**
 * Nested function captures self but isn't assigned to self so no retain loop.
 */
class NoAssignementNestedFunction : DoesSomething {
  var message = "nested function"

  let mappable = [1]

  func doSomething() {
    func closure(number: Int) {
      print(self.message)
    }

    mappable.map(closure)
  }

  deinit {
    print("DEALLOCATED")
  }
}

/**
 * Closure captures self but isn't assigned to self so no retain loop.
 */
class SafeInlineClosure : DoesSomething {
  var message = "inline closure"

  let mappable = [1]

  func doSomething() {
    mappable.map {_ in
      print(self.message)
    }
  }

  deinit {
    print("DEALLOCATED")
  }
}

var example: DoesSomething?

example = CompilerWarning()
example!.doSomething()
example = nil

example = MemoryLeak1()
example!.doSomething()
example = nil

example = MemoryLeak2()
example!.doSomething()
example = nil

example = SafeNestedFunctionWeakVar()
example!.doSomething()
example = nil

example = WeakSelfClosure()
example!.doSomething()
example = nil

example = NoAssignementNestedFunction()
example!.doSomething()
example = nil

example = SafeInlineClosure()
example!.doSomething()
example = nil


//: [Next](@next)
