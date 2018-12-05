//: [Previous](@previous)

import Foundation
import PlaygroundSupport

class AccessToken {
    let token: String

    init(_ token: String) {
        self.token = token
    }

    var isValid: Bool {
        return true
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)

    var value: T? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
}

class AccessTokenLoader {
    func load(completion: (Result<AccessToken>) -> Void) {
        completion(.success(AccessToken("Toto")))
    }
}

class AccessTokenService {
    typealias Handler = (Result<AccessToken>) -> Void

    private let loader: AccessTokenLoader
    private let queue: DispatchQueue
    private var token: AccessToken?
    private var pendingHandlers = [Handler]()

    init(loader: AccessTokenLoader,
         queue: DispatchQueue = .init(label: "AccessToken")) {
        self.loader = loader
        self.queue = queue
    }

    func retrieveToken(then handler: @escaping Handler) {
        queue.async { [weak self] in
            self?.performRetrieval(with: handler)
        }
    }
}

private extension AccessTokenService {
    func performRetrieval(with handler: @escaping Handler) {
        if let token = token, token.isValid {
            return handler(.success(token))
        }

        pendingHandlers.append(handler)

        guard pendingHandlers.count == 1 else {
            return
        }

        loader.load { [weak self] result in
            self?.queue.async {
                self?.handle(result)
            }
        }
    }

    func handle(_ result: Result<AccessToken>) {
        token = result.value

        let handlers = pendingHandlers
        pendingHandlers = []
        handlers.forEach { $0(result) }
    }
}

let loader = AccessTokenLoader()
let sut = AccessTokenService(loader: loader)
sut.retrieveToken { result in
    print(result)
}

PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
