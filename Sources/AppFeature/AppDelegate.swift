import ComposableArchitecture
import UserDefaultsClient

public struct AppDelegateState: Equatable {}

public enum AppDelegateAction: Equatable {
  case didFinishLaunching
}

struct AppDelegateEnvironment {
  var userDefaultsClient: UserDefaultsClient
}

let appDelegateReducer = Reducer<
  AppDelegateState, AppDelegateAction, AppDelegateEnvironment
> { state, action, environment in
  switch action {
  case .didFinishLaunching:
    return environment.userDefaultsClient.setOpenedAppCount(
      environment.userDefaultsClient.openedAppCount + 1
    )
    .fireAndForget()
  }
}
