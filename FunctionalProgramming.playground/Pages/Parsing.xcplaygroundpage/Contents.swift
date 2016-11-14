//: [Previous](@previous)

import Foundation

protocol ResultParsing {
  associatedtype ParsedType
  func parseData(data: NSData) -> ParsedType?
}



protocol StringParsing: ResultParsing { }

extension StringParsing {
  func parseData(data: NSData) -> String? {
    return NSString(data: data, encoding: NSUTF8StringEncoding) as? String
  }
}



protocol JSONConstructable {
  init(data: NSData)
}

struct User: JSONConstructable {
  init(data: NSData) {
  }
}

struct Tweet: JSONConstructable {
  init(data: NSData) {
  }
}

protocol JSONParsing: ResultParsing {
  associatedtype JSONType: JSONConstructable
  func parseData(data: NSData) -> JSONType?
}

extension JSONParsing {
  func parseData(data: NSData) -> JSONType? {
    return JSONType(data: data)
  }
}

//: [Next](@next)
