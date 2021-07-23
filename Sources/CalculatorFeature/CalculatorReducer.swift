import ComposableArchitecture
import UserDefaultsClient
import FeedbackGeneratorClient
import Calculator

var calculator = Calculator()

public let calculatorReducer = Reducer<CalculatorState, CalculatorAction, CalculatorEnvironment> {
  state, action, environment in
  
  switch action {
  case .onAppear:
    let hasRequestReviewBefore = environment.userDefaultsClient.lastReviewRequestTimeinterval != 0
    let timeSinceLastReviewRequest = environment.mainRunLoop.now.date.timeIntervalSince1970
      - environment.userDefaultsClient.lastReviewRequestTimeinterval
    let weekInSeconds: Double = 60 * 60 * 24 * 7
    let openedAppCount = environment.userDefaultsClient.openedAppCount
    
    return openedAppCount > 3 && (!hasRequestReviewBefore || timeSinceLastReviewRequest >= weekInSeconds)
      ? Effect.merge(
        environment.userDefaultsClient.setLastReviewRequestTimeinterval(
          environment.mainRunLoop.now.date.timeIntervalSince1970
        )
        .fireAndForget(),
        environment.storeKitClient.requestReview().fireAndForget()
      )
      : Effect.none
  case let .tappedButton(symbol):
    if Int(symbol) != nil {
      return environment.userDefaultsClient.hasCalculatorButtonTappedFeedback
        ? Effect.merge(
          environment.feedbackGeneratorClient
            .selectionChanged()
            .fireAndForget(),
          Effect(value: CalculatorAction.touchDigit(symbol))
            .eraseToEffect()
        )
        : Effect(value: CalculatorAction.touchDigit(symbol))
    } else {
      return environment.userDefaultsClient.hasCalculatorButtonTappedFeedback
        ? Effect.merge(
          environment.feedbackGeneratorClient
            .selectionChanged()
            .fireAndForget(),
          Effect(value: CalculatorAction.performOperation(symbol))
            .eraseToEffect()
        )
        : Effect(value: CalculatorAction.performOperation(symbol))
    }
  case let .touchDigit(digit):
    if state.userIsInTheMiddleOfTyping {
      state.number += digit
    } else {
      state.number = digit
      state.userIsInTheMiddleOfTyping = true
    }
    return .none
  case let .performOperation(digit):
    if state.userIsInTheMiddleOfTyping {
      calculator.setOperand(Double(state.number)!)
      state.userIsInTheMiddleOfTyping = false
    }
    calculator.performOperation(digit)
    if let result = calculator.result {
      state.number = String(result)
    }
    return .none
  }
}
