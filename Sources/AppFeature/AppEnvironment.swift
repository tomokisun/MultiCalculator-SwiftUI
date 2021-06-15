import UIApplicationClient
import Build
import ComposableArchitecture
import UIKit

public struct AppEnvironment {
  public var setUserInterfaceStyle: (UIUserInterfaceStyle) -> Effect<Never, Never>
  public var build: Build
  public var applicationClient: UIApplicationClient

  public init(
    setUserInterfaceStyle: @escaping (UIUserInterfaceStyle) -> Effect<Never, Never>,
    build: Build,
    applicationClient: UIApplicationClient
  ) {
    self.setUserInterfaceStyle = setUserInterfaceStyle
    self.build = build
    self.applicationClient = applicationClient
  }

  public static let noop = Self(
    setUserInterfaceStyle: { _ in .none },
    build: .noop,
    applicationClient: .noop
  )
}
