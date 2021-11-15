import UIKit

protocol B: Item {}
protocol B1: B {}

protocol A {
    associatedtype AB
    var b: AB { get }
}

class B2: B {
    required init(filename: String) {}
}

class A1: Screen {
    typealias T = B2
    var items = [T]()

    init(b: [B2]) {
        self.items = b
    }
}

//var a1 = A1(b: B2())
//print(a1.b)


protocol Item {
    init(filename: String)
}
protocol Screen {
    associatedtype ItemType: Item
    var items: [ItemType] { get set }
}
