import ComposableArchitecture
import DeviceStateModifier
import MultiCalculatorFeature
import SettingFeature
import SwiftUI

public struct AppState: Equatable {
  public var multiCalculator = MultiCalculatorState()
  public var setting = SettingState()
  public var appDelegate = AppDelegateState()

  public init() {}
}

public enum AppAction: Equatable {
  case onAppear
  case multiCalculator(MultiCalculatorAction)
  case setting(SettingAction)
  case appDelegate(AppDelegateAction)
}

extension AppEnvironment {
  var multiCalculator: MultiCalculatorEnvironment {
    .init(
      feedbackGeneratorClient: feedbackGeneratorClient,
      userDefaultsClient: userDefaultsClient
    )
  }
  var setting: SettingEnvironment {
    .init(
      build: build,
      applicationClient: applicationClient,
      userDefaultsClient: userDefaultsClient
    )
  }
  var appDelegate: AppDelegateEnvironment {
    .init(userDefaultsClient: userDefaultsClient)
  }
}

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
  multiCalculatorReducer
    .pullback(
      state: \AppState.multiCalculator,
      action: /AppAction.multiCalculator,
      environment: \.multiCalculator
    ),

  settingReducer
    .pullback(
      state: \AppState.setting,
      action: /AppAction.setting,
      environment: \.setting
    ),

  appDelegateReducer
    .pullback(
      state: \AppState.appDelegate,
      action: /AppAction.appDelegate,
      environment: \.appDelegate
    ),

  Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .onAppear:
      let hasRequestReviewBefore = environment.userDefaultsClient.lastReviewRequestTimeinterval != 0
      let timeSinceLastReviewRequest =
        environment.mainRunLoop.now.date.timeIntervalSince1970
        - environment.userDefaultsClient.lastReviewRequestTimeinterval
      let weekInSeconds: Double = 60 * 60 * 24 * 7
      let openedAppCount = environment.userDefaultsClient.openedAppCount

      return openedAppCount > 3
        && (!hasRequestReviewBefore || timeSinceLastReviewRequest >= weekInSeconds)
        ? Effect.merge(
          environment.userDefaultsClient.setLastReviewRequestTimeinterval(
            environment.mainRunLoop.now.date.timeIntervalSince1970
          )
          .fireAndForget(),
          environment.storeKitClient.requestReview().fireAndForget()
        )
        : Effect.none
    case .multiCalculator:
      return .none
    case .setting:
      return .none
    case .appDelegate:
      return .none
    }
  }
)

public struct AppView: View {
  let store: Store<AppState, AppAction>
  @Environment(\.colorScheme) var colorScheme

  public init(
    store: Store<AppState, AppAction>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      NavigationView {
        VStack {
          HStack {
            Spacer()
            NavigationLink(
              destination: SettingView(
                store: self.store.scope(
                  state: \.setting,
                  action: AppAction.setting
                )
              ),
              label: {
                Image(systemName: "gear")
              }
            )
            .padding(4)
          }
          .font(.system(size: 24))
          .foregroundColor(colorScheme == .light ? .black : .white)

          MultiCalculatorView(
            store: self.store.scope(
              state: \.multiCalculator,
              action: AppAction.multiCalculator
            )
          )
        }
        .navigationBarHidden(true)
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .zIndex(0)
      .modifier(DeviceStateModifier())
      .onAppear {
        viewStore.send(.onAppear)
      }
    }
  }
}

struct AppViewPreview: PreviewProvider {
  static var previews: some View {
    AppView(
      store: Store(
        initialState: .init(),
        reducer: appReducer,
        environment: .noop
      )
    )
  }
}
