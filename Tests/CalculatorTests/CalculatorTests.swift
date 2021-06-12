import XCTest
import Calculator

class CalculatorTests: XCTestCase {
  var calculator = Calculator()
  
  override func setUp() {
    super.setUp()
    
    self.calculator = .init()
  }
  
  func testOperations() {
    XCTAssertNotNil(calculator.operations["AC"])
    XCTAssertNotNil(calculator.operations["%"])
    XCTAssertNotNil(calculator.operations["±"])
    XCTAssertNotNil(calculator.operations["×"])
    XCTAssertNotNil(calculator.operations["÷"])
    XCTAssertNotNil(calculator.operations["+"])
    XCTAssertNotNil(calculator.operations["−"])
    XCTAssertNotNil(calculator.operations["="])
  }
  
  func testPerformOperation() {
    XCTContext.runActivity(named: "performOperation") { _ in
      XCTContext.runActivity(named: "AC") { _ in
        calculator.performOperation("AC")
        XCTAssertEqual(calculator.accumulator, 0)
        XCTAssertNil(calculator.pendingBinaryOperation)
      }
      
      XCTContext.runActivity(named: "%") { _ in
        calculator.setOperand(12345)
        calculator.performOperation("%")
        XCTAssertEqual(calculator.accumulator, 123.45)
      }
      
      XCTContext.runActivity(named: "+ to -") { _ in
        calculator.setOperand(12345)
        calculator.performOperation("±")
        XCTAssertEqual(calculator.accumulator, -12345)
      }
      
      XCTContext.runActivity(named: "- to +") { _ in
        calculator.setOperand(-12345)
        calculator.performOperation("±")
        XCTAssertEqual(calculator.accumulator, 12345)
      }
      
      XCTContext.runActivity(named: "×") { _ in
        calculator.setOperand(123)
        XCTAssertEqual(calculator.accumulator, 123)
        calculator.performOperation("×")
        XCTAssertNil(calculator.accumulator)
        calculator.setOperand(456)
        XCTAssertEqual(calculator.accumulator, 456)
        calculator.performOperation("=")
        XCTAssertEqual(calculator.accumulator, 56088.0)
        XCTAssertNil(calculator.pendingBinaryOperation)
      }
      
      XCTContext.runActivity(named: "÷") { _ in
        calculator.setOperand(300)
        XCTAssertEqual(calculator.accumulator, 300)
        calculator.performOperation("÷")
        XCTAssertNil(calculator.accumulator)
        calculator.setOperand(200)
        XCTAssertEqual(calculator.accumulator, 200)
        calculator.performOperation("=")
        XCTAssertEqual(calculator.accumulator, 1.5)
        XCTAssertNil(calculator.pendingBinaryOperation)
      }
      
      XCTContext.runActivity(named: "+") { _ in
        calculator.setOperand(123)
        XCTAssertEqual(calculator.accumulator, 123)
        calculator.performOperation("+")
        XCTAssertNil(calculator.accumulator)
        calculator.setOperand(456)
        XCTAssertEqual(calculator.accumulator, 456)
        calculator.performOperation("=")
        XCTAssertEqual(calculator.accumulator, 579.0)
        XCTAssertNil(calculator.pendingBinaryOperation)
      }
      
      XCTContext.runActivity(named: "−") { _ in
        calculator.setOperand(123)
        XCTAssertEqual(calculator.accumulator, 123)
        calculator.performOperation("−")
        XCTAssertNil(calculator.accumulator)
        calculator.setOperand(456)
        XCTAssertEqual(calculator.accumulator, 456)
        calculator.performOperation("=")
        XCTAssertEqual(calculator.accumulator, -333.0)
        XCTAssertNil(calculator.pendingBinaryOperation)
      }
    }
  }
}
