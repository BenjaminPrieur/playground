//: [Previous](@previous)

import Foundation
import UIKit

enum ViewState {
  case Normal
  case Highlighted
  case Disabled
}

struct StateValue<T> {

  private let normal: T?
  private let highlighted: T?
  private let disabled: T?

  init(normal: T? = nil, highlighted: T? = nil, disabled: T? = nil) {
    self.normal = normal
    self.highlighted = highlighted
    self.disabled = disabled
  }

}

extension StateValue {
  subscript (state: ViewState) -> T? {
    switch state {
    case .Normal:
      return normal
    case .Highlighted:
      return highlighted
    case .Disabled:
      return disabled
    }
  }
}

extension UIButton {
  func new_setTitleColor(stateValue: StateValue<UIColor>) {
    setTitleColor(stateValue[.Normal], forState: .Normal)
    setTitleColor(stateValue[.Highlighted], forState: .Highlighted)
    setTitleColor(stateValue[.Disabled], forState: .Disabled)
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
      return StateValue(normal: .yellowColor(), highlighted: .blueColor(), disabled: .grayColor())
    case .Airplane:
      return StateValue(normal: .purpleColor(), highlighted: .greenColor(), disabled: .redColor())
    }
  }
}

let vehicleButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

func setTitleColorForStylableItem(stylable: Stylable) {
  vehicleButton.new_setTitleColor(stylable.buttonColor)
}

let car = Vehicle.Car
setTitleColorForStylableItem(car)

//: [Next](@next)
