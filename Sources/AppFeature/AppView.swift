import SwiftUI
import CalculatorFeature
import ComposableArchitecture

public struct AppState: Equatable {
  public var calculator: CalculatorState
  
  public init(
    calculator: CalculatorState = .init()
  ) {
    self.calculator = calculator
  }
}

public enum AppAction: Equatable {
  case sceneDelegate(SceneDelegateAction)
  case calculator(CalculatorAction)
}

extension AppEnvironment {
  var calculator: CalculatorEnvironment {
    .init()
  }
}

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
  sceneDelegateReducer
    .pullback(
      state: \.calculator,
      action: /AppAction.sceneDelegate,
      environment: {
        .init(
          setUserInterfaceStyle: $0.setUserInterfaceStyle
        )
      }
    )
)

let appReducerCore = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
  switch action {
  case let .sceneDelegate(.interfaceOrientation(interfaceOrientation)):
    state.calculator.userInterfaceOrientation = interfaceOrientation
    return .none
  case .calculator:
    return .none
  }
}

public struct AppView: View {
  let store: Store<AppState, AppAction>
  
  public init(
    store: Store<AppState, AppAction>
  ) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(self.store) { viewStore in
      CalculatorView(store: self.store.scope(state: \.calculator, action: AppAction.calculator))
    }
  }
}
