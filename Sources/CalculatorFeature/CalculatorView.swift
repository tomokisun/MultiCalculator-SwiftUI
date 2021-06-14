import Calculator
import ComposableArchitecture
import SwiftUI
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

public enum CalculatorAction: Equatable {
  case tappedButton(String)
  case touchDigit(String)
  case performOperation(String)
}

public struct CalculatorEnvironment {
  public init() {}
}

var calculator = Calculator()

public let calculatorReducer = Reducer<CalculatorState, CalculatorAction, CalculatorEnvironment> {
  state, action, _ in

  switch action {
  case let .tappedButton(symbol):
    if Int(symbol) != nil {
      return Effect(value: CalculatorAction.touchDigit(symbol))
    } else {
      return Effect(value: CalculatorAction.performOperation(symbol))
    }
  case let .touchDigit(digit):
    if state.userIsInTheMiddleOfTyping {
      state.number += digit
    } else {
      state.number = digit
      state.userIsInTheMiddleOfTyping = true
    }
    return .none
  case let .performOperation(digit):
    if state.userIsInTheMiddleOfTyping {
      calculator.setOperand(Double(state.number)!)
      state.userIsInTheMiddleOfTyping = false
    }
    calculator.performOperation(digit)
    if let result = calculator.result {
      state.number = String(result)
    }
    return .none
  }
}

public struct CalculatorView: View {
  public let store: Store<CalculatorState, CalculatorAction>

  public init(
    store: Store<CalculatorState, CalculatorAction>
  ) {
    self.store = store
  }

  public var body: some View {
    GeometryReader { reader in
      WithViewStore(self.store) { viewStore in
        VStack(alignment: .center, spacing: 8) {
          Spacer()
          Text(viewStore.displayNumber)
            .font(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
          Spacer()
          HStack {
            ForEach(["AC", "±", "％", "÷"], id: \.self) { title in
              CalculatorButton(title: title, action: { viewStore.send(.tappedButton(title)) })
                .frame(width: reader.size.width / 5)
            }
          }
          .frame(height: reader.size.width / 5)

          HStack {
            ForEach(["7", "8", "9", "×"], id: \.self) { title in
              CalculatorButton(title: title, action: { viewStore.send(.tappedButton(title)) })
                .frame(width: reader.size.width / 5)
            }
          }
          .frame(height: reader.size.width / 5)

          HStack {
            ForEach(["4", "5", "6", "-"], id: \.self) { title in
              CalculatorButton(title: title, action: { viewStore.send(.tappedButton(title)) })
                .frame(width: reader.size.width / 5)
            }
          }
          .frame(height: reader.size.width / 5)

          HStack {
            ForEach(["1", "2", "3", "+"], id: \.self) { title in
              CalculatorButton(title: title, action: { viewStore.send(.tappedButton(title)) })
                .frame(width: reader.size.width / 5)
            }
          }
          .frame(height: reader.size.width / 5)

          HStack {
            CalculatorButton(title: "0", action: { viewStore.send(.tappedButton("0")) })
              .frame(width: reader.size.width / 5 * 3)
            CalculatorButton(title: "=", action: { viewStore.send(.tappedButton("=")) })
              .frame(width: reader.size.width / 5)
          }
          .frame(height: reader.size.width / 5)
        }
        .background(Color(.systemBackground))
      }
    }
  }
}

struct CalculatorViewPreview: PreviewProvider {
  static var previews: some View {
    CalculatorView(
      store: .init(
        initialState: .init(),
        reducer: calculatorReducer,
        environment: .init()
      )
    )
  }
}
