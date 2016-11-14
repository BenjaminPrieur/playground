//: [Previous](@previous)

import UIKit

func image(fromBase64 string: String?) -> UIImage? {
	guard let base64 = string
		, let data = Data(base64Encoded: base64)
		, let photo = UIImage(data: data) else {
			return nil
	}
	return photo
}

func imageOptimize(fromBase64 string: String?) -> UIImage? {
	return string
		.flatMap { Data(base64Encoded: $0) }
		.flatMap { UIImage(data: $0) }
}

//: [Next](@next)
