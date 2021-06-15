import Build
import ComposableArchitecture
import UIApplicationClient
import UIKit
import FeedbackGeneratorClient
import UserDefaultsClient

public struct AppEnvironment {
  public var setUserInterfaceStyle: (UIUserInterfaceStyle) -> Effect<Never, Never>
  public var build: Build
  public var applicationClient: UIApplicationClient
  public var feedbackGeneratorClient: FeedbackGeneratorClient
  public var userDefaultsClient: UserDefaultsClient

  public init(
    setUserInterfaceStyle: @escaping (UIUserInterfaceStyle) -> Effect<Never, Never>,
    build: Build,
    applicationClient: UIApplicationClient,
    feedbackGeneratorClient: FeedbackGeneratorClient,
    userDefaultsClient: UserDefaultsClient
  ) {
    self.setUserInterfaceStyle = setUserInterfaceStyle
    self.build = build
    self.applicationClient = applicationClient
    self.feedbackGeneratorClient = feedbackGeneratorClient
    self.userDefaultsClient = userDefaultsClient
  }

  public static let noop = Self(
    setUserInterfaceStyle: { _ in .none },
    build: .noop,
    applicationClient: .noop,
    feedbackGeneratorClient: .noop,
    userDefaultsClient: .noop
  )
}
