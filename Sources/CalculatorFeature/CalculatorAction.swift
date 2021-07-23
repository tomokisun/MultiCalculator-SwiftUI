import ComposableArchitecture

public enum CalculatorAction: Equatable {
  case tappedButton(String)
  case touchDigit(String)
  case performOperation(String)
}
