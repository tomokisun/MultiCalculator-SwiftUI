import ComposableArchitecture
import DeviceStateModifier
import MultiCalculatorFeature
import SettingFeature
import SwiftUI

public struct AppState: Equatable {
  public var multiCalculator: MultiCalculatorState = .init()
  public var setting: SettingState

  public init(
    multiCalculator: MultiCalculatorState = .init(),
    setting: SettingState = .init()
  ) {
    self.multiCalculator = multiCalculator
    self.setting = setting
  }
}

public enum AppAction: Equatable {
  case multiCalculator(MultiCalculatorAction)
  case setting(SettingAction)
}

extension AppEnvironment {
  var multiCalculator: MultiCalculatorEnvironment {
    .init(
      feedbackGeneratorClient: feedbackGeneratorClient
    )
  }
  var setting: SettingEnvironment {
    .init(
      build: build,
      applicationClient: applicationClient
    )
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

  appReducerCore
)

let appReducerCore = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
  switch action {
  case .multiCalculator:
    return .none
  case .setting:
    return .none
  }
}

public struct AppView: View {
  let store: Store<AppState, AppAction>

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
          .foregroundColor(.black)

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
    }
  }
}

struct AppViewPreview: PreviewProvider {
  static var previews: some View {
    AppView(
      store: Store(
        initialState: .init(
          multiCalculator: .init(),
          setting: .init(build: .noop)
        ),
        reducer: appReducer,
        environment: .noop
      )
    )
  }
}
