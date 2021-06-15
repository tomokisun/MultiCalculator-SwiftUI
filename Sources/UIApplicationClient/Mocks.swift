import ComposableArchitecture
import XCTestDynamicOverlay

extension UIApplicationClient {
  public static let noop = Self(
    open: { _, _ in .none }
  )
}
