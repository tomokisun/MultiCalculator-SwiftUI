import Foundation

public struct Build: Equatable {
  public var version: () -> String
  public var number: () -> String

  public init(
    version: @escaping () -> String,
    number: @escaping () -> String
  ) {
    self.version = version
    self.number = number
  }

  public static let live: Self = {
    return Self(
      version: { Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "" },
      number: { Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "" }
    )
  }()

  public static let noop = Self(
    version: { "2021.5.12" },
    number: { "12345" }
  )

  public static func == (lhs: Build, rhs: Build) -> Bool {
    return lhs.version() == rhs.version()
      && lhs.number() == rhs.number()
  }
}
