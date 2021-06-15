import Build
import ComposableArchitecture
import Styleguide
import SwiftUI
import UIApplicationClient

public struct SettingState: Equatable {
  public var build: Build?

  public init(
    build: Build? = nil
  ) {
    self.build = build
  }
}

public enum SettingAction: Equatable {
  case onAppear
  case leaveUsAReviewButtonTapped
}

public struct SettingEnvironment {
  public var build: Build
  public var applicationClient: UIApplicationClient

  public init(
    build: Build,
    applicationClient: UIApplicationClient
  ) {
    self.build = build
    self.applicationClient = applicationClient
  }
}

extension SettingEnvironment {
  static let noop = Self(
    build: .noop,
    applicationClient: .noop
  )
}

public let settingReducer = Reducer<SettingState, SettingAction, SettingEnvironment> {
  state, action, environment in
  switch action {
  case .onAppear:
    state.build = environment.build
    return .none
  case .leaveUsAReviewButtonTapped:
    return environment.applicationClient
      .open(
        URL(string: "https://apps.apple.com/jp/app/id1525626543?mt=8&action=write-review")!, [:]
      )
      .fireAndForget()
  }
}

public struct SettingView: View {

  let store: Store<SettingState, SettingAction>

  public init(
    store: Store<SettingState, SettingAction>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      Form {
        SupportAppView(store: store)
        Section(header: Text("")) {
          HStack {
            Text("version")
            Spacer()
            if let version = viewStore.build?.version() {
              Text(version)
            }
          }
          HStack {
            Text("number")
            Spacer()
            if let number = viewStore.build?.number() {
              Text(number)
            } else {
            }
          }
        }
      }
      .navigationStyle(
        backgroundColor: .white,
        foregroundColor: .black,
        title: Text("Settings"),
        navPresentationStyle: .navigation,
        onDismiss: {}
      )
      .onAppear { viewStore.send(.onAppear) }
    }
  }
}

struct SettingViewPreview: PreviewProvider {
  static var previews: some View {
    SettingView(
      store: Store(
        initialState: .init(
          build: .noop
        ),
        reducer: settingReducer,
        environment: .noop
      )
    )
  }
}
