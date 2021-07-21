import Combine
import ComposableArchitecture
import StoreKit

public struct StoreKitClient {
  public var requestReview: () -> Effect<Never, Never>
}
