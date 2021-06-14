import ComposableArchitecture

struct UserDefaultsClientKey {
}

public struct UserDefaultsClient {
  public var integerForKey: (String) -> Int
  public var setInteger: (Int, String) -> Effect<Never, Never>
}
