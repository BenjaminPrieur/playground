//: [Previous](@previous)

import Foundation

struct Model: Codable {
    var blob: String
}

func decode(_ result: Result<Data, Error>) throws -> Model {
    // Using Result's 'get' method, we can either extract its
    // underlying value, or throw any error that it contains:
    let data = try result.get()
    let decoder = JSONDecoder()
    return try decoder.decode(Model.self, from: data)
}

var json = """
{"blob":"foo"}
"""

let dataResult: Result<Data, Error> = .success(json.data(using: .utf8)!)

let stringResult = dataResult.map {
    String(decoding: $0, as: UTF8.self)
}

print(try decode(dataResult))
print(try stringResult.get())

//: [Next](@next)
