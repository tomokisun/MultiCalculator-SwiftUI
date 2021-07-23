import ComposableArchitecture
import FeedbackGeneratorClient
import UserDefaultsClient
import StoreKitClient

public struct CalculatorEnvironment {
  public var feedbackGeneratorClient: FeedbackGeneratorClient
  public var userDefaultsClient: UserDefaultsClient
  public var mainRunLoop: AnySchedulerOf<RunLoop>
  public var storeKitClient: StoreKitClient

  public init(
    feedbackGeneratorClient: FeedbackGeneratorClient,
    userDefaultsClient: UserDefaultsClient,
    mainRunLoop: AnySchedulerOf<RunLoop>,
    storeKitClient: StoreKitClient
  ) {
    self.feedbackGeneratorClient = feedbackGeneratorClient
    self.userDefaultsClient = userDefaultsClient
    self.mainRunLoop = mainRunLoop
    self.storeKitClient = storeKitClient
  }

  static let noop = Self(
    feedbackGeneratorClient: .noop,
    userDefaultsClient: .noop,
    mainRunLoop: .immediate,
    storeKitClient: .noop
  )
}
