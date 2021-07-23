extension UserDefaultsClient {
  public static let noop = Self(
    boolForKey: { _ in false },
    integerForKey: { _ in 0 },
    doubleForKey: { _ in 0 },
    setBool: { _, _ in .none },
    setInteger: { _, _ in .none },
    setDouble: { _, _ in .none }
  )
}
