import SwiftUI

public struct CalculatorButton: View {
  public let title: String
  public var action: () -> Void

  public init(
    title: String,
    action: @escaping () -> Void
  ) {
    self.title = title
    self.action = action
  }

  public var body: some View {
    Button(
      action: action,
      label: {
        Text(title)
          .font(.system(size: 28, weight: .bold, design: .default))
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .foregroundColor(.white)
          .background(Color.secondary)
          .cornerRadius(.infinity)
      })
  }
}

struct CalculatorButtonPreviews: PreviewProvider {
  static var previews: some View {
    Group {
      CalculatorButton(title: "AC", action: {})
        .frame(width: 50, height: 50)
        .colorScheme(.light)

      CalculatorButton(title: "AC", action: {})
        .frame(width: 50, height: 50)
        .colorScheme(.dark)
    }
    .previewLayout(.sizeThatFits)
  }
}
