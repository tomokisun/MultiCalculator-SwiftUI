import SwiftUI
import CalculatorFeature
import ComposableArchitecture
import SettingFeature

public struct AppState: Equatable {
  public var calculator: CalculatorState
  public var setting: SettingState
  
  public init(
    calculator: CalculatorState = .init(),
    setting: SettingState = .init()
  ) {
    self.calculator = calculator
    self.setting = setting
  }
}

public enum AppAction: Equatable {
  case calculator(CalculatorAction)
  case setting(SettingAction)
}

extension AppEnvironment {
  var calculator: CalculatorEnvironment {
    .init()
  }
  var setting: SettingEnvironment {
    .init(
      build: build
    )
  }
}

public let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
  calculatorReducer
    .pullback(
      state: \AppState.calculator,
      action: /AppAction.calculator,
      environment: \.calculator
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
  case .calculator:
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
          }
          .font(.system(size: 24))
          .foregroundColor(.black)
          
          CalculatorView(
            store: self.store.scope(
              state: \.calculator,
              action: AppAction.calculator
            )
          )
        }
        .navigationBarHidden(true)
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .zIndex(0)
    }
  }
}

struct AppViewPreview: PreviewProvider {
  static var previews: some View {
    AppView(
      store: Store(
        initialState: .init(
          calculator: .init(),
          setting: .init(build: .noop)
        ),
        reducer: appReducer,
        environment: .noop
      )
    )
  }
}
