import ComposableArchitecture

struct UserDefaultsClientKey {
  static let hasCalculatorButtonTappedFeedback = "has-calculator-button-tapped-feedback"
}

public struct UserDefaultsClient {
  public var boolForKey: (String) -> Bool
  public var integerForKey: (String) -> Int
  public var setBool: (Bool, String) -> Effect<Never, Never>
  public var setInteger: (Int, String) -> Effect<Never, Never>

  public var hasCalculatorButtonTappedFeedback: Bool {
    self.boolForKey(UserDefaultsClientKey.hasCalculatorButtonTappedFeedback)
  }
}
