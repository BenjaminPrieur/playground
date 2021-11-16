//: [Previous](@previous)

import Foundation

// *********************************************************************
// MARK: - Key
struct DefinitionKey: Hashable, Equatable {
	var protocolType: Any.Type

	var hashValue: Int {
		return "\(protocolType)".hashValue
	}
}

func ==(lhs: DefinitionKey, rhs: DefinitionKey) -> Bool {
	return lhs.protocolType == rhs.protocolType
}

// *********************************************************************
// MARK: - DefinitionOf
protocol Definition {}

final class DefinitionOf<T>: Definition {
	let factory: Any

	init(factory: Any) {
		self.factory = factory
	}
}

// *********************************************************************
// MARK: - Injector
enum InjectorError: Error {
	case unknownDependency
	case noInjection
}

class AppInjector {

	static let shared: AppInjector = AppInjector()
	var dependencies: [DefinitionKey: Any] = [:]

	func addDependency<T>(_ object: T) {
		let key = DefinitionKey(protocolType: T.self)
		dependencies[key] = object
	}

	func addDependency<T>(_ factory: @escaping () -> T)  {
		let object = factory() as T
		addDependency(object)
	}

	func inject<T>() throws -> T {
		let key = DefinitionKey(protocolType: T.self)
		guard let dependency = dependencies[key] as? T else {
			throw InjectorError.unknownDependency
		}
		return dependency
	}
}


// *********************************************************************
// MARK: - Tests

protocol Service {
	func test() -> String
}

class ServiceBis: Service {
	func test() -> String {
		return "Bis"
	}
}
class ServiceImp: Service {
	func test() -> String {
		return "Imp"
	}
}

protocol Client: AnyObject {}
class ClientImp: Client {}

AppInjector.shared.addDependency(ServiceBis())
AppInjector.shared.addDependency { ServiceImp() as Service }
//AppInjector.shared.addDependency { ServiceBis() as Service }
AppInjector.shared.addDependency { ClientImp() as Client }

print(AppInjector.shared.dependencies)

let client: Client = try! AppInjector.shared.inject()
let service: Service = try! AppInjector.shared.inject()
service.test()
let serviceBis: ServiceBis = try! AppInjector.shared.inject()
serviceBis.test()

//: [Next](@next)
