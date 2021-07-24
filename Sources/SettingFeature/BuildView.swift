import ComposableArchitecture
import SwiftUI

struct BuildView: View {
  public let store: Store<SettingState, SettingAction>
  @ObservedObject var viewStore: ViewStore<SettingState, SettingAction>

  public init(
    store: Store<SettingState, SettingAction>
  ) {
    self.store = store
    self.viewStore = ViewStore(self.store)
  }

  var body: some View {
    Section {
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
}
