import ComposableArchitecture
import UIKit

extension String {
  var formatDouble: String {
    guard
      let double = Double(self),
      let int = Int(exactly: double)
    else {
      return self
    }
    return int.description
  }
}

public struct CalculatorState: Equatable {
  var number = "0"
  var displayNumber: String {
    number.formatDouble
  }
  var userIsInTheMiddleOfTyping = false
  public var userInterfaceOrientation: UIInterfaceOrientation = .unknown

  public init() {}
}
