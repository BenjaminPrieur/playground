//: Playground - noun: a place where people can play

import UIKit

class Toto : NSObject {

}

class Test : Toto {
    var something: Int = 12
}

let test: Test = Test()

print(type(of: test))
print(test.self)


func image(fromBase64 string: String?) -> UIImage? {
	return string
		.flatMap { Data(base64Encoded: $0) }
		.flatMap { UIImage(data: $0) }
}
