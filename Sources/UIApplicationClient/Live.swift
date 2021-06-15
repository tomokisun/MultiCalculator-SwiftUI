import UIKit

extension UIApplicationClient {
  public static let live = Self(
    open: { url, options in
      .future { callback in
        UIApplication.shared.open(url, options: options) { bool in
          callback(.success(bool))
        }
      }
    }
  )
}
