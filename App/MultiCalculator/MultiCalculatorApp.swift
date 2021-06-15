import AppFeature
import Build
import ComposableArchitecture
import SwiftUI

@main
struct MultiCalculatorApp: App {

  let store = Store(
    initialState: .init(),
    reducer: appReducer,
    environment: .live
  )

  var body: some Scene {
    WindowGroup {
      AppView(store: store)
    }
  }
}

extension AppEnvironment {
  static let live = Self(
    setUserInterfaceStyle: { userInterfaceStyle in
      .fireAndForget {
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = userInterfaceStyle
      }
    },
    build: .live,
    applicationClient: .live
  )
}
