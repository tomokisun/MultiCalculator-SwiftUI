import Foundation

extension UserDefaultsClient {
  public static func live(
    userDefaults: UserDefaults = .standard
  ) -> Self {
    Self(
      integerForKey: userDefaults.integer(forKey:),
      setInteger: { value, key in
        .fireAndForget {
          userDefaults.set(value, forKey: key)
        }
      }
    )
  }
}
