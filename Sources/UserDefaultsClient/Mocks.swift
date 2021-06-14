extension UserDefaultsClient {
  public static let noop = Self(
    integerForKey: { _ in 0 },
    setInteger: { _, _ in .none }
  )
}
