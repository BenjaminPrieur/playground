//: [Previous](@previous)

import Foundation

protocol AdvertisingManagerDelegate: class {
	func topMethod()
}

class AdvertisingManager {
	weak var delegate: AdvertisingManagerDelegate!

	func presentAds() {
		delegate.topMethod()
	}
}

class Player {
//	var adsManager: AdvertisingManager!
	var adsBehavior: AdvertisingManagerBehaviour!

	init(adsBehavior: AdvertisingManagerBehaviour) {
//		adsManager = AdvertisingManager()
//		adsManager.delegate = self
		self.adsBehavior = adsBehavior
		self.adsBehavior.player = self
	}

	func start() {
//		adsManager.presentAds()
		adsBehavior.adsManager.presentAds()
	}
}

//extension Player: AdvertisingManagerDelegate {
//	func topMethod() {
//		print("player top method did call")
//	}
//}

class AdvertisingManagerBehaviour: AdvertisingManagerDelegate {

	var adsManager: AdvertisingManager!
	weak var player: Player?

	init(adsManager: AdvertisingManager = AdvertisingManager()) {
		self.adsManager = adsManager
		self.adsManager.delegate = self
	}

	func topMethod() {
		print("AdvertisingManagerBehaviour top method did call")
	}

}

class SuperAdvertisingManagerBehavior: AdvertisingManagerBehaviour {

	override func topMethod() {
		print("SuperAdvertisingManagerBehavior top method did call")
	}
}

let player = Player(adsBehavior: SuperAdvertisingManagerBehavior())
player.start()

//: [Next](@next)
