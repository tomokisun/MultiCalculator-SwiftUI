import ComposableArchitecture
import MultiCalculatorFeature
import SwiftUI
import DeviceStateModifier

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
      .modifier(DeviceStateModifier())
    }
  }
}
