import SwiftUI

public struct DeviceStateModifier: ViewModifier {
  @State var state = DeviceState.default

  public init() {}

  public func body(content: Content) -> some View {
    content
      .onAppear()
      .onReceive(
        NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)
      ) { _ in
        state.previousOrientation = self.state.orientation
        state.orientation = UIDevice.current.orientation
      }
      .environment(\.deviceState, state)
  }
}

extension EnvironmentValues {
  public var deviceState: DeviceState {
    get { self[DeviceStateKey.self] }
    set { self[DeviceStateKey.self] = newValue }
  }
}

private struct DeviceStateKey: EnvironmentKey {
  static var defaultValue: DeviceState {
    .default
  }
}
