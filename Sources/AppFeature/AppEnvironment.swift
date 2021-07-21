import Build
import ComposableArchitecture
import FeedbackGeneratorClient
import UIApplicationClient
import UIKit
import UserDefaultsClient
import StoreKitClient

public struct AppEnvironment {
  public var setUserInterfaceStyle: (UIUserInterfaceStyle) -> Effect<Never, Never>
  public var build: Build
  public var applicationClient: UIApplicationClient
  public var feedbackGeneratorClient: FeedbackGeneratorClient
  public var userDefaultsClient: UserDefaultsClient
  public var storeKitClient: StoreKitClient

  public init(
    setUserInterfaceStyle: @escaping (UIUserInterfaceStyle) -> Effect<Never, Never>,
    build: Build,
    applicationClient: UIApplicationClient,
    feedbackGeneratorClient: FeedbackGeneratorClient,
    userDefaultsClient: UserDefaultsClient,
    storeKitClient: StoreKitClient
  ) {
    self.setUserInterfaceStyle = setUserInterfaceStyle
    self.build = build
    self.applicationClient = applicationClient
    self.feedbackGeneratorClient = feedbackGeneratorClient
    self.userDefaultsClient = userDefaultsClient
    self.storeKitClient = storeKitClient
  }

  public static let noop = Self(
    setUserInterfaceStyle: { _ in .none },
    build: .noop,
    applicationClient: .noop,
    feedbackGeneratorClient: .noop,
    userDefaultsClient: .noop,
    storeKitClient: .noop
  )
}
