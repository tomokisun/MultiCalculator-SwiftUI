import SwiftUI

public struct DeviceState {
  public var idiom: UIUserInterfaceIdiom
  public var orientation: UIDeviceOrientation
  public var previousOrientation: UIDeviceOrientation

  public static let `default` = Self(
    idiom: UIDevice.current.userInterfaceIdiom,
    orientation: UIDevice.current.orientation,
    previousOrientation: UIDevice.current.orientation
  )

  public var isPad: Bool {
    idiom == .pad
  }

  public var isPhone: Bool {
    idiom == .phone
  }

  #if DEBUG
    public static let phone = Self(
      idiom: .phone,
      orientation: .portrait,
      previousOrientation: .portrait
    )

    public static let pad = Self(
      idiom: .pad,
      orientation: .portrait,
      previousOrientation: .portrait
    )
  #endif
}
