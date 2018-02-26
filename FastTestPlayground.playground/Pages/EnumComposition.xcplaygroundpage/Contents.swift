//: [Previous](@previous)

import Foundation
import UIKit

class ImageProcessingViewController: UIViewController {

	func processImages(_ images: [UIImage]) {
		// Create an operation that processes all images in
		// the background, and either throws or succeeds.
		let operation = Operation {
			let processor = ImageProcessor()
			try images.forEach(processor.process)
		}

		// *********************************************************************
		// MARK: - Before

		// We pass a closure as a state handler, and for each
		// state we update the UI accordingly.
//		operation.startWithStateHandler { [weak self] state in
//			switch state {
//			case .loading:
//				self?.showActivityIndicatorIfNeeded()
//			case .failed(let error):
//				self?.cleanupCache()
//				self?.removeActivityIndicator()
//				self?.showErrorView(for: error)
//			case .finished:
//				self?.cleanupCache()
//				self?.removeActivityIndicator()
//				self?.showFinishedView()
//			}
//		}


		// *********************************************************************
		// MARK: - After

		operation.startWithStateHandler { [weak self] state in
			switch state {
			case .loading:
				self?.showActivityIndicatorIfNeeded()
			case .finished(let outcome):
				// All common actions for both the success & failure
				// outcome can now be moved into a single place.
				self?.cleanupCache()
				self?.removeActivityIndicator()

				switch outcome {
				case .failed(let error):
					self?.showErrorView(for: error)
				case .succeeded:
					self?.showFinishedView()
				}
			}
		}

	}

}

let json = JSON.arrayValue([JSON.dictionaryValue(["name":JSON.dictionaryValue(["first": JSON.stringValue("Ben")])])])
print(json[0]?["name"]?["first"]?.stringValue)

//: [Next](@next)
