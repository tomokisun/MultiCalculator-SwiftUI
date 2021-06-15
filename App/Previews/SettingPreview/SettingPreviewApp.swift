import SettingFeature
import SwiftUI
import ComposableArchitecture

@main
struct SettingPreviewApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationView {
        SettingView(
          store: Store(
            initialState: .init(),
            reducer: settingReducer,
            environment: .init(build: .noop)
          )
        )
      }
    }
  }
}
