import ComposableArchitecture
import DeviceStateModifier
import MultiCalculatorFeature
import SwiftUI

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
