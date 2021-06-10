import SwiftUI
import CalculatorFeature

@main
struct AppApp: App {
  var body: some Scene {
    WindowGroup {
      CalculatorView(
        store: .init(
          initialState: .init(),
          reducer: calculatorReducer,
          environment: .init()
        )
      )
    }
  }
}
