import AppFeature
import Build
import ComposableArchitecture
import FeedbackGeneratorClient
import SwiftUI
import UserDefaultsClient

final class AppDelegate: NSObject, UIApplicationDelegate {
  let store = Store(
    initialState: .init(),
    reducer: appReducer,
    environment: .live
  )
  lazy var viewStore = ViewStore(
    self.store.scope(state: { _ in () }),
    removeDuplicates: ==
  )
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil)
  -> Bool {
    self.viewStore.send(.appDelegate(.didFinishLaunching))
    return true
  }
}

@main
struct MultiCalculatorApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

  var body: some Scene {
    WindowGroup {
      AppView(store: self.appDelegate.store)
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
    applicationClient: .live,
    feedbackGeneratorClient: .live,
    userDefaultsClient: .live(),
    storeKitClient: .live,
    backgroundQueue: DispatchQueue(label: "background-queue").eraseToAnyScheduler(),
    mainQueue: .main,
    mainRunLoop: .main,
    timeZone: { .autoupdatingCurrent }
  )
}
