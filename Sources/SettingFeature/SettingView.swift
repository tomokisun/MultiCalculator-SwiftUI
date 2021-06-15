import Build
import ComposableArchitecture
import Styleguide
import SwiftUI

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
}

public struct SettingEnvironment {
  public var build: Build

  public init(
    build: Build
  ) {
    self.build = build
  }
}

public let settingReducer = Reducer<SettingState, SettingAction, SettingEnvironment> {
  state, action, environment in
  switch action {
  case .onAppear:
    state.build = environment.build
    return .none
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
        environment: .init(
          build: .noop
        )
      )
    )
  }
}
