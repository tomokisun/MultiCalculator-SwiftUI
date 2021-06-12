import CalculatorFeature
import SwiftUI

@main
struct MultiCalculatorApp: App {
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
