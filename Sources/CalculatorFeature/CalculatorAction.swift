import ComposableArchitecture

public enum CalculatorAction: Equatable {
  case onAppear
  case tappedButton(String)
  case touchDigit(String)
  case performOperation(String)
}
