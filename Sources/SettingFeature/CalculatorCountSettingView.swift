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
    Section(header: Text("")) {
      HStack {
        Text("portrait")
        Spacer()
        Stepper(
          value: viewStore.binding(
            get: { $0.portraitCount },
            send: SettingAction.stepperChanged
          )
        ) {
          Text("\(viewStore.portraitCount)")
        }
      }
    }
  }
}
