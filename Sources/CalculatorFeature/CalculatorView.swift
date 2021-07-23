import ComposableArchitecture
import DeviceStateModifier
import SwiftUI

public struct CalculatorView: View {
  public let store: Store<CalculatorState, CalculatorAction>
  @Environment(\.deviceState) var deviceState

  public init(
    store: Store<CalculatorState, CalculatorAction>
  ) {
    self.store = store
  }

  public var body: some View {
    GeometryReader { reader in
      WithViewStore(self.store) { viewStore in
        VStack(alignment: .center, spacing: 8) {
          Spacer()
          Text(viewStore.displayNumber)
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .trailing)

          if deviceState.orientation.isPortrait {
            Spacer()
          }

          HStack {
            ForEach(["AC", "±", "%", "÷"], id: \.self) { title in
              CalculatorButton(title: title, action: { viewStore.send(.tappedButton(title)) })
                .frame(width: reader.size.width / 5)
            }
          }
          .frame(height: reader.size.width / 5)

          HStack {
            ForEach(["7", "8", "9", "×"], id: \.self) { title in
              CalculatorButton(title: title, action: { viewStore.send(.tappedButton(title)) })
                .frame(width: reader.size.width / 5)
            }
          }
          .frame(height: reader.size.width / 5)

          HStack {
            ForEach(["4", "5", "6", "-"], id: \.self) { title in
              CalculatorButton(title: title, action: { viewStore.send(.tappedButton(title)) })
                .frame(width: reader.size.width / 5)
            }
          }
          .frame(height: reader.size.width / 5)

          HStack {
            ForEach(["1", "2", "3", "+"], id: \.self) { title in
              CalculatorButton(title: title, action: { viewStore.send(.tappedButton(title)) })
                .frame(width: reader.size.width / 5)
            }
          }
          .frame(height: reader.size.width / 5)

          HStack {
            CalculatorButton(title: "0", action: { viewStore.send(.tappedButton("0")) })
              .frame(width: reader.size.width / 5 * 3)
            CalculatorButton(title: "=", action: { viewStore.send(.tappedButton("=")) })
              .frame(width: reader.size.width / 5)
          }
          .frame(height: reader.size.width / 5)
        }
        .background(Color(.systemBackground))
      }
    }
  }
}

struct CalculatorViewPreview: PreviewProvider {
  static var previews: some View {
    CalculatorView(
      store: .init(
        initialState: .init(),
        reducer: calculatorReducer,
        environment: .noop
      )
    )
  }
}
