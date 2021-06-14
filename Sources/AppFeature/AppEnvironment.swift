import Build
import ComposableArchitecture
import UIKit

public struct AppEnvironment {
  public var setUserInterfaceStyle: (UIUserInterfaceStyle) -> Effect<Never, Never>
  public var build: Build

  public init(
    setUserInterfaceStyle: @escaping (UIUserInterfaceStyle) -> Effect<Never, Never>,
    build: Build
  ) {
    self.setUserInterfaceStyle = setUserInterfaceStyle
    self.build = build
  }

  public static let noop = Self(
    setUserInterfaceStyle: { _ in .none },
    build: .noop
  )
}
