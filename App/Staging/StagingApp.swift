import AppFeature
import SwiftUI
import Build
import ComposableArchitecture

@main
struct StagingApp: App {
  
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
  static let live: Self = {
    let build = Build.live
    return Self(
      setUserInterfaceStyle: { userInterfaceStyle in
        .fireAndForget {
          UIApplication.shared.windows.first?.overrideUserInterfaceStyle = userInterfaceStyle
        }
      },
      build: build
    )
  }()
}
