//: [Previous](@previous)

import Foundation

protocol Widget {
    init()
}

class A: Widget {
    required init() {}
}
class B: Widget {
    required init() {}
    let test = "Coucou"
}

class MyWidgets {
    var myWidgets = [Widget]()

    func createWidget<T: Widget>(ofType: T.Type) -> T {
        let widget = T.init()
        myWidgets.append(widget)
        return widget
    }
}

var sut = MyWidgets()
sut.createWidget(ofType: A.self)
sut.createWidget(ofType: B.self).test
print(sut.myWidgets.count)

// *********************************************************************
// MARK: - DeeplinkHandler

protocol DeepLink: AnyObject {
    static var identifier: String { get }
}

protocol DeepLinkHandler: class {
    var handledDeepLinks: [DeepLink.Type] { get }
    func canHandle(deepLink: DeepLink) -> Bool
    func handle(deepLink: DeepLink)
}

extension DeepLinkHandler {
    func canHandle(deepLink: DeepLink) -> Bool {
        let deepLinkType = type(of: deepLink)
        //Unfortunately, metatypes can't be added to Sets as they don't conform to Hashable!
        return handledDeepLinks.contains { $0.identifier == deepLinkType.identifier }
    }
}

class HomeDeepLink: DeepLink {
    static let identifier: String = "HomeDeepLink"
}
class PurchaseDeepLink: DeepLink {
    static let identifier: String = "PurchaseDeepLink"
}

class MyClass: DeepLinkHandler {
    var handledDeepLinks: [DeepLink.Type] {
        return [HomeDeepLink.self, PurchaseDeepLink.self]
    }

    func handle(deepLink: DeepLink) {
        switch deepLink {
        case let deepLink as HomeDeepLink:
            break
        case let deepLink as PurchaseDeepLink:
            break
        default:
            break
        }
    }
}

// *********************************************************************
// MARK: - A/B testing

protocol Experiment: AnyObject {
    static var identifier: String { get }
}
class HomeExperiment: Experiment {
    static let identifier = "HomeExperiment"
    var showNewHomeScreen = true
}

class ExperimentManager {
    static let shared = ExperimentManager()
    var experimentDictionary = [String: Experiment]()

    static func get<T: Experiment>(_ experiment: T.Type) -> T? {
        return shared.experimentDictionary[experiment.identifier] as? T
    }

    static func activate(_ experiment: Experiment) {
        shared.experimentDictionary[type(of: experiment).identifier] = experiment
    }
}

ExperimentManager.activate(HomeExperiment())
if ExperimentManager.get(HomeExperiment.self)?.showNewHomeScreen == true {
    print("Show new home")
} else {
    print("Show old home")
}

//: [Next](@next)
