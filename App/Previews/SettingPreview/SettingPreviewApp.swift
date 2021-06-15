import ComposableArchitecture
import SettingFeature
import SwiftUI

@main
struct SettingPreviewApp: App {
  var body: some Scene {
    WindowGroup {
      NavigationView {
        SettingView(
          store: Store(
            initialState: .init(),
            reducer: settingReducer,
            environment: .init(
              build: .live,
              applicationClient: .live
            )
          )
        )
      }
    }
  }
}
