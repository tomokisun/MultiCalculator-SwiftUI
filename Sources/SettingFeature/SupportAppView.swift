import ComposableArchitecture
import SwiftUI

public struct SupportAppView: View {

  public let store: Store<SettingState, SettingAction>
  @ObservedObject var viewStore: ViewStore<SettingState, SettingAction>
  @State var isSharePresented = false

  public init(
    store: Store<SettingState, SettingAction>
  ) {
    self.store = store
    self.viewStore = ViewStore(self.store)
  }

  public var body: some View {
    Section(header: Text("")) {
      Button(action: { viewStore.send(.leaveUsAReviewButtonTapped) }) {
        HStack {
          Image(systemName: "star")
          Text("Leave us a review")
          Spacer()
          ChevronImage()
        }
      }

      Button(action: { isSharePresented.toggle() }) {
        HStack {
          Image(systemName: "person.2.fill")
          Text("Share with a friend!")
          Spacer()
          ChevronImage()
        }
      }
      .sheet(isPresented: $isSharePresented) {
        ActivityView(activityItems: [URL(string: "https://apps.apple.com/jp/app/id1525626543")!])
      }
    }
    .foregroundColor(.primary)
  }
}

public struct ActivityView: UIViewControllerRepresentable {
  public var activityItems: [Any]

  public init(activityItems: [Any]) {
    self.activityItems = activityItems
  }

  public func makeUIViewController(context: Context) -> UIActivityViewController {
    let controller = UIActivityViewController(
      activityItems: self.activityItems,
      applicationActivities: nil
    )
    return controller
  }

  public func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context)
  {}
}
