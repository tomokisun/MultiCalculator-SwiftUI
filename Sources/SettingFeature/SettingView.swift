import ComposableArchitecture
import Styleguide
import SwiftUI

public struct SettingView: View {
  let store: Store<SettingState, SettingAction>
  @Environment(\.colorScheme) var colorScheme

  public init(
    store: Store<SettingState, SettingAction>
  ) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(self.store) { viewStore in
      Form {
        SupportAppView(store: store)
        FeedbackSettingView(store: store)
        CalculatorCountSettingView(store: store)
        BuildView(store: store)
      }
      .navigationStyle(
        backgroundColor: colorScheme == .light ? .white : .black,
        foregroundColor: colorScheme == .light ? .black : .white,
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
