//: [Previous](@previous)

import Foundation

extension URLRequest {
    func tokenRequestModifier(_ token: String) -> URLRequest {
        var request = self
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}

func tokenRequestModifier(_ token: String) -> (URLRequest) -> URLRequest {
    return { request in
        var request = request
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}

let urlRequest = URLRequest(url: URL(string: "www.google.com")!)
print(tokenRequestModifier("token")(urlRequest))
print(urlRequest.tokenRequestModifier("token"))


//: [Next](@next)
