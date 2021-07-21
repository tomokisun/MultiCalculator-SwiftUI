import Combine
import ComposableArchitecture
import StoreKit

extension StoreKitClient {
  public static func live() -> Self {
    return Self(
      requestReview: {
        .fireAndForget {
          #if canImport(UIKit)
          guard let windowScene = UIApplication.shared.windows.first?.windowScene
          else { return }
          SKStoreReviewController.requestReview(in: windowScene)
          #endif
        }
      }
    )
  }
}
