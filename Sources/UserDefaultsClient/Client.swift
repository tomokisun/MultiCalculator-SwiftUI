import ComposableArchitecture

struct UserDefaultsClientKey {
  static let hasCalculatorButtonTappedFeedback = "has-calculator-button-tapped-feedback"
  static let portraitCalculatorCount = "portrait-calculator-count"
  static let landscapeCalculatorCount = "landscape-calculator-count"
}

public struct UserDefaultsClient {
  public var boolForKey: (String) -> Bool
  public var integerForKey: (String) -> Int
  public var setBool: (Bool, String) -> Effect<Never, Never>
  public var setInteger: (Int, String) -> Effect<Never, Never>

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
}
