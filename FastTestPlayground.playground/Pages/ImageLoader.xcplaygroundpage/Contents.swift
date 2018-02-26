//: [Previous](@previous)

import Foundation
import UIKit

enum Result<T> {
	case success(T)
	case failure(Error)
}

protocol ImageLoader {
	typealias Handler = (Result<UIImage>) -> Void

	func loadImage(from url: URL, then handler: Handler)
}

class ImageLoaderFactory {
	private let session: URLSession

	init(session: URLSession = .shared) {
		self.session = session
	}

	func makeImageLoader() -> ImageLoader {
		return SessionImageLoader(session: session)
	}
}

private extension ImageLoaderFactory {
	class SessionImageLoader: ImageLoader {
		let session: URLSession
		private var ongoingRequest = Set<Request>()

		init(session: URLSession) {
			self.session = session
		}

		deinit {
			cancelAllRequests()
		}

		func loadImage(from url: URL, then handler: Handler) {
			let request = Request(url: url, handler: handler)
			perform(request)
		}

		func cancelAllRequests() {
//			ongoingRequest
		}
	}
}

//: [Next](@next)
