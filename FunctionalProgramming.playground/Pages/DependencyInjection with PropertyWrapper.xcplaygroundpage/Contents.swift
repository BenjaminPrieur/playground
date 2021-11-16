//: [Previous](@previous)

import Foundation

@propertyWrapper
struct Inject<T> {
//    private var value: T
    private(set) var wrappedValue: T

    init(di: DependencyManager = .shared) {
        self.wrappedValue = try! di.resolve()
    }
}

// *********************************************************************
// MARK: - Injector
enum InjectorError: Error {
    case unknownDependency
}

class DependencyManager {
    private var storage = [String: Any]()

    static let shared = DependencyManager()
    init() {}

    func add<T>(_ injectable: T) {
        let key = String(describing: T.self)
        storage[key] = injectable
    }

    func add<T>(_ factory: @escaping () -> T)  {
        let object = factory() as T
        add(object)
    }

    func resolve<T>() throws -> T {
        let key = String(describing: T.self)

        guard let injectable = storage[key] as? T else {
            throw InjectorError.unknownDependency
//            fatalError("\(key) has not been added as an injectable object.")
        }

        return injectable
    }
}

protocol UserManager {
    func test()
}
class UserManagerImpl: UserManager {
    func test() {
        print("Test")
    }
}

var sessionContainer = DependencyManager()
sessionContainer.add { UserManagerImpl() as UserManager }

class testClass {
//    @Inject var userManager: UserManager
    @Inject(di: .shared) var userManager: UserManager
}

DependencyManager.shared.add { UserManagerImpl() as UserManager }

let test = testClass()
test.userManager.test()
let userManager: UserManager = try! sessionContainer.resolve()
userManager.test()

//: [Next](@next)
