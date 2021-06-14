import ComposableArchitecture
import UIKit

public enum SceneDelegateAction: Equatable {
  case interfaceOrientation(UIInterfaceOrientation)
}

public struct SceneDelegateEnvironment {
  var setUserInterfaceStyle: (UIUserInterfaceStyle) -> Effect<Never, Never>
}
