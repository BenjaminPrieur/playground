//: [Previous](@previous)

import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

/// A custom protocol for logging outgoing requests.
final class PrintProtocol: URLProtocol {

    override open class func canInit(with request: URLRequest) -> Bool {
        // Print valuable request information.
        print("🚀 Running request: \(request.httpMethod ?? "") - \(request.url?.absoluteString ?? "")")

        // By returning `false`, this URLProtocol will do nothing less than logging.
        return false
    }
}

// Register the custom URL Protocol.
URLProtocol.registerClass(PrintProtocol.self)

// Execute a data request.
URLSession.shared.dataTask(with: URL(string: "https://www.google.com/")!) { (_, _, _) in
    print("✅ Request completed")
}.resume()

//: [Next](@next)
