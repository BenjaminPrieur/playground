//: [Previous](@previous)

import Foundation
import UIKit

enum ViewState {
  case normal
  case highlighted
  case disabled
}

struct StateValue<T> {

  fileprivate let normal: T?
  fileprivate let highlighted: T?
  fileprivate let disabled: T?

  init(normal: T? = nil, highlighted: T? = nil, disabled: T? = nil) {
    self.normal = normal
    self.highlighted = highlighted
    self.disabled = disabled
  }

}

extension StateValue {
  subscript (state: ViewState) -> T? {
    switch state {
    case .normal:
      return normal
    case .highlighted:
      return highlighted
    case .disabled:
      return disabled
    }
  }
}

extension UIButton {
  func new_setTitleColor(stateValue: StateValue<UIColor>) {
    setTitleColor(stateValue[.normal], for: .normal)
    setTitleColor(stateValue[.highlighted], for: .highlighted)
    setTitleColor(stateValue[.disabled], for: .disabled)
  }
}

//let button = UIButton()
//let buttonState: StateValue<UIColor> = StateValue(normal: .purpleColor(), highlighted: .greenColor(), disabled: .redColor())
//button.new_setTitleColor(buttonState)


enum Vehicle {
  case Car
  case Airplane
}

protocol Stylable {
  var buttonColor: StateValue<UIColor> { get }
}

extension Vehicle: Stylable {
  var buttonColor: StateValue<UIColor>  {
    switch self {
    case .Car:
      return StateValue(normal: .yellow, highlighted: .blue, disabled: .gray)
    case .Airplane:
      return StateValue(normal: .purple, highlighted: .green, disabled: .red)      
    }
  }
}

let vehicleButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

func setTitleColorForStylableItem(stylable: Stylable) {
  vehicleButton.new_setTitleColor(stateValue: stylable.buttonColor)
}

let car = Vehicle.Car
setTitleColorForStylableItem(stylable: car)

//: [Next](@next)
