import XCTest
import SwiftUI
import SnapshotTesting
import CalculatorFeature
import ComposableArchitecture
import SnapshotTestHelper

class CalculatorViewTests: XCTestCase {
  override func setUp() {
    super.setUp()
    
    diffTool = "ksdiff"
  }
  
  func testCalculatorView() {
    for colorScheme in ColorScheme.allCases {
      for (name, config) in viewConfigs {
        assertSnapshot(
          matching: CalculatorView(
            store: Store(
              initialState: CalculatorState(),
              reducer: .empty,
              environment: ()
            )
          )
          .colorScheme(colorScheme),
          as: .image(
            precision: 0.9,
            layout: .device(config: config)
          ),
          named: name + "\(colorScheme)"
        )
      }
    }
  }
}
