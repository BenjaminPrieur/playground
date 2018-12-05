//: [Previous](@previous)

import Foundation
import UIKit
import PlaygroundSupport

class ViewController:UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()

        var label = UILabel(frame: CGRect(x: 20, y: 20, width: 80, height: 22))
        label.text = "DEMO"
        view.backgroundColor = .white
        view.addSubview(label)

        label.layout {
            $0.top == view.topAnchor + 20
            $0.leading == view.leadingAnchor + 50
            $0.width <= view.widthAnchor - 40
        }
    }

}

let viewController = ViewController()

//var containerView = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
//containerView.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)


PlaygroundPage.current.liveView = viewController
PlaygroundPage.current.needsIndefiniteExecution = true

//: [Next](@next)
