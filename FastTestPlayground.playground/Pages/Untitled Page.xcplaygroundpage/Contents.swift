//: Playground - noun: a place where people can play

import UIKit

class Toto: NSObject {
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

struct ProgrammingLanguage: OptionSet {
	let rawValue: Int

	static let swift = ProgrammingLanguage(rawValue: 1)
	static let scala = ProgrammingLanguage(rawValue: 2)
	static let haskell = ProgrammingLanguage(rawValue: 4)
	static let objc = ProgrammingLanguage(rawValue: 8)
	static let php = ProgrammingLanguage(rawValue: 16)
}

let programmingLanguages: ProgrammingLanguage = [.swift, .scala]
print(programmingLanguages.contains(.haskell))


//var array = [Int](repeating: 0, count: 5)
//print(unsafeAddressOf(array as AnyObject), terminator: "")
//let newArray = array
//print(unsafeAddressOf(newArray as AnyObject), terminator: "")
//array[3] = 3
//print(array)
//print(newArray)

let a = NSString(format: "Toto")
var b = a
b = "jack"
print(a == b)

var strings: [String] = []

// *********************************************************************
// MARK: - Test constraint

let view = UIView()
let tableView = UITableView()

view.addSubview(tableView)

NSLayoutConstraint.activate([
	tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
	tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
	tableView.topAnchor.constraint(equalTo: view.topAnchor),
	tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
])


class APM {
	var conf: String
	init(conf: String) {
		self.conf = conf
	}
}

let apm = APM(conf: "FirstConf")

class Manager {
	var conf: String
	init(conf: String) {
		self.conf = conf
	}
}

var aManager = Manager(conf: apm.conf)
var bManager = Manager(conf: apm.conf)

apm.conf = "SecondConf"

print(aManager.conf == bManager.conf)
print(aManager.conf == apm.conf)

