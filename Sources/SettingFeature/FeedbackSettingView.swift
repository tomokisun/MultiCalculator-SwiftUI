import ComposableArchitecture
import SwiftUI

struct FeedbackSettingView: View {
  let store: Store<SettingState, SettingAction>
  @ObservedObject var viewStore: ViewStore<SettingState, SettingAction>

  init(store: Store<SettingState, SettingAction>) {
    self.store = store
    self.viewStore = ViewStore(self.store)
  }
  
  var body: some View {
    Section(header: Text("")) {
      Toggle(
        "Haptics feedback",
        isOn: self.viewStore.binding(
          keyPath: \.enableFeedback,
          send: SettingAction.binding
        )
      )
      .font(.system(size: 16))
    }
  }
}
