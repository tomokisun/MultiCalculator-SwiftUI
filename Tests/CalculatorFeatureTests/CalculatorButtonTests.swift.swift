import XCTest
import SwiftUI
import CalculatorFeature
import SnapshotTesting

class CalculatorButtonTests: XCTestCase {
  override func setUp() {
    super.setUp()
    
    diffTool = "ksdiff"
  }

  func testNumbers() {
    let numbers = 0...9
    for title in numbers.map(String.init) {
      print(title)
      let view = CalculatorButton(title: title, action: {})
        .frame(width: 50, height: 50)
        .previewLayout(.sizeThatFits)
      assertSnapshot(
        matching: view,
        as: .image(precision: 0.9)
      )
    }
  }
}
