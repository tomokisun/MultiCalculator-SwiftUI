import SwiftUI
import Calculator
import ComposableArchitecture

public struct CalculatorState: Equatable {
  var count: Double = 0.0
  var displayNumber = "" {
    didSet {
      print(displayNumber)
    }
  }
  var userIsInTheMiddleOfTyping = false
  
  public init() {}
}

public enum CalculatorAction: Equatable {
  case tappedButton(String)
  case touchDigit(String)
  case performOperation(String)
}

public struct CalculatorEnvironment {
  let calculator = Calculator()
  public init() {}
}

public let calculatorReducer = Reducer<CalculatorState, CalculatorAction, CalculatorEnvironment> { state, action, _ in
  
  var calculator = Calculator()
  
  switch action {
  case let .tappedButton(symbol):
    if Int(symbol) != nil {
      return Effect(value: CalculatorAction.touchDigit(symbol))
    } else {
      return Effect(value: CalculatorAction.performOperation(symbol))
    }
  case let .touchDigit(digit):
    if state.userIsInTheMiddleOfTyping {
      state.displayNumber += digit
    } else {
      state.displayNumber = digit
      state.userIsInTheMiddleOfTyping = true
    }
    return .none
  case let .performOperation(digit):
    if state.userIsInTheMiddleOfTyping {
      calculator.setOperand(Double(state.displayNumber)!)
      state.userIsInTheMiddleOfTyping = false
    }
    calculator.performOperation(digit)
    if let result = calculator.result {
      state.displayNumber = String(result)
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
    WithViewStore(self.store) { viewStore in
      GeometryReader { reader in
        VStack(alignment: .center) {
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
