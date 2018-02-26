//: [Previous](@previous)

import Foundation
import XCTest

class MyTestCase: XCTestCase {

	func testAsyncTest() {

		performTest { expectation in
			expectation.fulfill()
		}

	}

	func performTest(using closure: (XCTestExpectation) throws -> Void) rethrows {

		let exp: XCTestExpectation = expectation(description: "")

		try closure(exp)

		waitForExpectations(timeout: 5.0) { error in
			if error != nil {
				XCTFail("expectation did not fulfill")
			}
		}

	}

}

class TestObserver: NSObject, XCTestObservation {
	func testCase(_ testCase: XCTestCase,
	              didFailWithDescription description: String,
	              inFile filePath: String?,
	              atLine lineNumber: UInt) {
		assertionFailure(description, line: lineNumber)
	}
}

let testObserver = TestObserver()
XCTestObservationCenter.shared().addTestObserver(testObserver)
MyTestCase.defaultTestSuite().run()

//: [Next](@next)
