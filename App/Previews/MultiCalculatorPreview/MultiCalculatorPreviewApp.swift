import SwiftUI
import ComposableArchitecture
import MultiCalculatorFeature

@main
struct MultiCalculatorPreviewApp: App {
  var body: some Scene {
    WindowGroup {
      MultiCalculatorView(
        store: Store(
          initialState: .init(),
          reducer: multiCalculatorReducer,
          environment: .noop
        )
      )
    }
  }
}
