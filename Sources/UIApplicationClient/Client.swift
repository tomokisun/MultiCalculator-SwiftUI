import ComposableArchitecture
import UIKit

public struct UIApplicationClient {
  public var open: (URL, [UIApplication.OpenExternalURLOptionsKey: Any]) -> Effect<Bool, Never>
}
