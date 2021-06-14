import UIKit
import ComposableArchitecture

public struct AppEnvironment {
  public var setUserInterfaceStyle: (UIUserInterfaceStyle) -> Effect<Never, Never>
  
  public init(
    setUserInterfaceStyle: @escaping (UIUserInterfaceStyle) -> Effect<Never, Never>
  ) {
    self.setUserInterfaceStyle = setUserInterfaceStyle
  }
}
