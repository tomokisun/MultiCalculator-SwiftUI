import ComposableArchitecture

struct UserDefaultsClientKey {
  static let hasCalculatorButtonTappedFeedback = "has-calculator-button-tapped-feedback"
  static let portraitCalculatorCount = "portrait-calculator-count"
  static let landscapeCalculatorCount = "landscape-calculator-count"
  static let lastReviewRequestTimeinterval = "last-review-request-timeinterval"
  static let openedAppCount = "opened-app-count"
}

public struct UserDefaultsClient {
  public var boolForKey: (String) -> Bool
  public var integerForKey: (String) -> Int
  public var doubleForKey: (String) -> Double
  public var setBool: (Bool, String) -> Effect<Never, Never>
  public var setInteger: (Int, String) -> Effect<Never, Never>
  public var setDouble: (Double, String) -> Effect<Never, Never>

  public var hasCalculatorButtonTappedFeedback: Bool {
    self.boolForKey(UserDefaultsClientKey.hasCalculatorButtonTappedFeedback)
  }

  public func setHasCalculatorButtonTappedFeedback(_ bool: Bool) -> Effect<Never, Never> {
    self.setBool(bool, UserDefaultsClientKey.hasCalculatorButtonTappedFeedback)
  }

  public var portraitCalculatorCount: Int {
    self.integerForKey(UserDefaultsClientKey.portraitCalculatorCount)
  }

  public func setPortraitCalculatorCount(_ integer: Int) -> Effect<Never, Never> {
    self.setInteger(integer, UserDefaultsClientKey.portraitCalculatorCount)
  }

  public var landscapeCalculatorCount: Int {
    self.integerForKey(UserDefaultsClientKey.landscapeCalculatorCount)
  }

  public func setLandscapeCalculatorCount(_ integer: Int) -> Effect<Never, Never> {
    self.setInteger(integer, UserDefaultsClientKey.landscapeCalculatorCount)
  }
  
  public var lastReviewRequestTimeinterval: Double {
    self.doubleForKey(UserDefaultsClientKey.lastReviewRequestTimeinterval)
  }
  
  public func setLastReviewRequestTimeinterval(_ double: Double) -> Effect<Never, Never> {
    self.setDouble(double, UserDefaultsClientKey.lastReviewRequestTimeinterval)
  }
  
  public var openedAppCount: Int {
    self.integerForKey(UserDefaultsClientKey.openedAppCount)
  }
  
  public func setOpenedAppCount(_ integer: Int) -> Effect<Never, Never> {
    self.setInteger(integer, UserDefaultsClientKey.openedAppCount)
  }
}
