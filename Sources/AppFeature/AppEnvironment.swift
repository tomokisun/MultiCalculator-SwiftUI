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
  public var backgroundQueue: AnySchedulerOf<DispatchQueue>
  public var mainQueue: AnySchedulerOf<DispatchQueue>
  public var mainRunLoop: AnySchedulerOf<RunLoop>
  public var timeZone: () -> TimeZone

  public init(
    setUserInterfaceStyle: @escaping (UIUserInterfaceStyle) -> Effect<Never, Never>,
    build: Build,
    applicationClient: UIApplicationClient,
    feedbackGeneratorClient: FeedbackGeneratorClient,
    userDefaultsClient: UserDefaultsClient,
    storeKitClient: StoreKitClient,
    backgroundQueue: AnySchedulerOf<DispatchQueue>,
    mainQueue: AnySchedulerOf<DispatchQueue>,
    mainRunLoop: AnySchedulerOf<RunLoop>,
    timeZone: @escaping () -> TimeZone
  ) {
    self.setUserInterfaceStyle = setUserInterfaceStyle
    self.build = build
    self.applicationClient = applicationClient
    self.feedbackGeneratorClient = feedbackGeneratorClient
    self.userDefaultsClient = userDefaultsClient
    self.storeKitClient = storeKitClient
    self.backgroundQueue = backgroundQueue
    self.mainQueue = mainQueue
    self.mainRunLoop = mainRunLoop
    self.timeZone = timeZone
  }

  public static let noop = Self(
    setUserInterfaceStyle: { _ in .none },
    build: .noop,
    applicationClient: .noop,
    feedbackGeneratorClient: .noop,
    userDefaultsClient: .noop,
    storeKitClient: .noop,
    backgroundQueue: .immediate,
    mainQueue: .immediate,
    mainRunLoop: .immediate,
    timeZone: { .autoupdatingCurrent }
  )
}
