import CalculatorFeature
import ComposableArchitecture
import DeviceStateModifier
import FeedbackGeneratorClient
import SwiftUI
import UserDefaultsClient

public struct MultiCalculatorState: Equatable {
  public var calculator1 = CalculatorState()
  public var calculator2 = CalculatorState()
  public var calculator3 = CalculatorState()

  public init() {}
}

public enum MultiCalculatorAction: Equatable {
  case calculator1(CalculatorAction)
  case calculator2(CalculatorAction)
  case calculator3(CalculatorAction)
  case onAppear
}

public struct MultiCalculatorEnvironment {
  public var feedbackGeneratorClient: FeedbackGeneratorClient
  public var userDefaultsClient: UserDefaultsClient

  public init(
    feedbackGeneratorClient: FeedbackGeneratorClient,
    userDefaultsClient: UserDefaultsClient
  ) {
    self.feedbackGeneratorClient = feedbackGeneratorClient
    self.userDefaultsClient = userDefaultsClient
  }
  public static let noop = Self(
    feedbackGeneratorClient: .noop,
    userDefaultsClient: .noop
  )
}

extension MultiCalculatorEnvironment {
  var calculator: CalculatorEnvironment {
    .init(
      feedbackGeneratorClient: feedbackGeneratorClient,
      userDefaultsClient: userDefaultsClient
    )
  }
}

public let multiCalculatorReducer = Reducer<
  MultiCalculatorState, MultiCalculatorAction, MultiCalculatorEnvironment
>.combine(
  calculatorReducer.pullback(
    state: \.calculator1,
    action: /MultiCalculatorAction.calculator1,
    environment: \.calculator
  ),

  calculatorReducer.pullback(
    state: \.calculator2,
    action: /MultiCalculatorAction.calculator2,
    environment: \.calculator
  ),

  calculatorReducer.pullback(
    state: \.calculator3,
    action: /MultiCalculatorAction.calculator3,
    environment: \.calculator
  ),

  Reducer { state, action, environment in
    switch action {
    case .onAppear:
      return .none
    case .calculator1:
      return .none
    case .calculator2:
      return .none
    case .calculator3:
      return .none
    }
  }
)

public struct MultiCalculatorView: View {
  let store: Store<MultiCalculatorState, MultiCalculatorAction>
  @Environment(\.deviceState) var deviceState

  public init(
    store: Store<MultiCalculatorState, MultiCalculatorAction>
  ) {
    self.store = store
  }

  public var body: some View {
    GeometryReader { geometry in
      WithViewStore(self.store) { viewStore in
        HStack {
          CalculatorView(
            store: self.store.scope(
              state: \.calculator1,
              action: MultiCalculatorAction.calculator1
            )
          )
          if deviceState.isPad || deviceState.orientation.isLandscape {
            CalculatorView(
              store: self.store.scope(
                state: \.calculator2,
                action: MultiCalculatorAction.calculator2
              )
            )
            CalculatorView(
              store: self.store.scope(
                state: \.calculator3,
                action: MultiCalculatorAction.calculator3
              )
            )
          }
        }
      }
    }
  }
}

struct MultiCalculatorViewPreview: PreviewProvider {
  static var previews: some View {
    MultiCalculatorView(
      store: Store(
        initialState: .init(),
        reducer: multiCalculatorReducer,
        environment: .noop
      )
    )
  }
}
