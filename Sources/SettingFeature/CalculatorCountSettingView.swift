import ComposableArchitecture
import SwiftUI

struct CalculatorCountSettingView: View {
  let store: Store<SettingState, SettingAction>
  @ObservedObject var viewStore: ViewStore<SettingState, SettingAction>

  init(store: Store<SettingState, SettingAction>) {
    self.store = store
    self.viewStore = ViewStore(self.store)
  }

  var body: some View {
    Section {
      HStack {
        Text("portrait")
        Spacer()
        Stepper(
          value: viewStore.binding(
            keyPath: \.portraitCount,
            send: SettingAction.binding
          ),
          in: 1...2,
          label: {
            Text(viewStore.portraitCount.description)
          }
        )
      }
      HStack {
        Text("landscape")
        Spacer()
        Stepper(
          value: viewStore.binding(
            keyPath: \.landscapeCount,
            send: SettingAction.binding
          ),
          in: 1...5,
          label: {
            Text(viewStore.landscapeCount.description)
          }
        )
      }
    }
  }
}
