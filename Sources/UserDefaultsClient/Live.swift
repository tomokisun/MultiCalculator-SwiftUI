import Foundation

extension UserDefaultsClient {
  public static func live(
    userDefaults: UserDefaults = .standard
  ) -> Self {
    Self(
      boolForKey: userDefaults.bool(forKey:),
      integerForKey: userDefaults.integer(forKey:),
      setBool: { value, key in
        .fireAndForget {
          userDefaults.set(value, forKey: key)
        }
      },
      setInteger: { value, key in
        .fireAndForget {
          userDefaults.set(value, forKey: key)
        }
      }
    )
  }
}
