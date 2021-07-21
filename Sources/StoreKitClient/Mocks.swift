import ComposableArchitecture

extension StoreKitClient {
  public static let noop = Self(
    requestReview: { .none }
  )
}

#if DEBUG
  import XCTestDynamicOverlay

  extension StoreKitClient {
    public static let failing = Self(
      requestReview: { .failing("\(Self.self).requestReview is unimplemented") }
    )
  }
#endif
