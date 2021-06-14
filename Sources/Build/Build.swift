import Foundation

public struct Build {
  public var version: () -> String
  public var number: () -> String
  
  public static let live = Self(
    version: { Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "" },
    number: { Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "" }
  )
}
