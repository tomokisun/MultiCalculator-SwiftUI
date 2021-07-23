import SwiftUI

struct ChevronImage: View {
  var body: some View {
    Image(systemName: "chevron.right")
      .foregroundColor(
        .init(
          red: 209 / 255,
          green: 209 / 255,
          blue: 213 / 255
        )
      )
  }
}

struct ChevronImagePreview: PreviewProvider {
  static var previews: some View {
    ChevronImage()
      .previewLayout(.sizeThatFits)
  }
}
