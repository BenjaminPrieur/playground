//: [Previous](@previous)

import Foundation
import XCTest
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

extension XCTestCase {
    enum AsyncError: Error {
        case failedUnwrappingResult
    }
    // We'll add a typealias for our closure types, to make our
    // new method signature a bit easier to read.
    typealias Function<T> = (T) -> Void

    func await<T>(_ function: (@escaping (T) -> Void) -> Void) throws -> T {
        let expectation = self.expectation(description: "Async call")
        var result: T?

        function() { value in
            result = value
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)

        guard let unwrappedResult = result else {
            throw awaitError()
        }

        return unwrappedResult
    }

    func await<A, R>(_ function: @escaping Function<(A, Function<R>)>,
                     calledWith argument: A) throws -> R {
        return try await { handler in
            function((argument, handler))
        }
    }

    func awaitError() -> Error {
        return AsyncError.failedUnwrappingResult
    }
}

class ImageResizer {
    var image: UIImage

    init(image: UIImage) {
        self.image = image
    }

    func resize(multipliedBy: Int, then callback: (UIImage) -> Void) {
        callback(UIImage())
    }
}

class ImageResizerTests: XCTestCase {
    func testResizingImage() throws {
        let originalSize = CGSize(width: 200, height: 100)
        let resizer = ImageResizer(image: UIImage())

        let resizedImage = try await(resizer.resize, calledWith: 5)
        XCTAssertEqual(resizedImage.size, CGSize(width: 1000, height: 500))
    }
}

let imageResizerTests = ImageResizerTests()
try imageResizerTests.testResizingImage()

//: [Next](@next)
