import ComposableArchitecture
import UIKit
import CalculatorFeature

public enum SceneDelegateAction: Equatable {
  case interfaceOrientation(UIInterfaceOrientation)
}

public struct SceneDelegateEnvironment {
  public var setUserInterfaceStyle: (UIUserInterfaceStyle) -> Effect<Never, Never>
  
  #if DEBUG
  static let failing = Self(
    setUserInterfaceStyle: { _ in .failing("setUserInterfaceStyle") }
  )
  #endif
}

let sceneDelegateReducer = Reducer<
  CalculatorState, SceneDelegateAction, SceneDelegateEnvironment
> { state, action, environment in
  switch action {
  case .interfaceOrientation(let interfaceOrientation):
    print(interfaceOrientation)
    return .none
  }
}
