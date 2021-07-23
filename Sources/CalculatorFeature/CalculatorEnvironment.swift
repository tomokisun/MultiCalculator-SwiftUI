import ComposableArchitecture
import FeedbackGeneratorClient
import UserDefaultsClient

public struct CalculatorEnvironment {
  public var feedbackGeneratorClient: FeedbackGeneratorClient
  public var userDefaultsClient: UserDefaultsClient

  public init(
    feedbackGeneratorClient: FeedbackGeneratorClient,
    userDefaultsClient: UserDefaultsClient
  ) {
    self.feedbackGeneratorClient = feedbackGeneratorClient
    self.userDefaultsClient = userDefaultsClient
  }

  static let noop = Self(
    feedbackGeneratorClient: .noop,
    userDefaultsClient: .noop
  )
}
