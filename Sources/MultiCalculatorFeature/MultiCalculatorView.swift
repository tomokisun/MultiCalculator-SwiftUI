import SwiftUI
import CalculatorFeature
import ComposableArchitecture

public struct MultiCalculatorState: Equatable {
  public var calculator: CalculatorState
  
  public init(
    calculator: CalculatorState = .init()
  ) {
    self.calculator = calculator
  }
}

public enum MultiCalculatorAction: Equatable {
  case calculator(CalculatorAction)
  case onAppear
}

public struct MultiCalculatorEnvironment {
  public static let noop = Self(
  )
}

extension MultiCalculatorEnvironment {
  var calculator: CalculatorEnvironment {
    .init()
  }
}

public let multiCalculatorReducer = Reducer<MultiCalculatorState, MultiCalculatorAction, MultiCalculatorEnvironment>.combine(
  calculatorReducer.pullback(
    state: \.calculator,
    action: /MultiCalculatorAction.calculator,
    environment: \.calculator
  ),
  
  Reducer { state, action, environment in
    switch action {
    case .onAppear:
      return .none
    case .calculator:
      return .none
    }
  }
)

public struct MultiCalculatorView: View {
  let store: Store<MultiCalculatorState, MultiCalculatorAction>
  
  public init(
    store: Store<MultiCalculatorState, MultiCalculatorAction>
  ) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
      Text("")
        .onAppear { viewStore.send(.onAppear) }
    }
  }
}

struct MultiCalculatorViewPreview: PreviewProvider {
  static var previews: some View {
    MultiCalculatorView(
      store: Store(
        initialState: .init(),
        reducer: multiCalculatorReducer,
        environment: .noop
      )
    )
  }
}
