import Build
import ComposableArchitecture
import Styleguide
import SwiftUI
import UIApplicationClient
import UserDefaultsClient

public struct SettingState: Equatable {
  public var build: Build?
  public var enableFeedback: Bool
  public var portraitCount = 0

  public init(
    build: Build? = nil,
    enableFeedback: Bool = false
  ) {
    self.build = build
    self.enableFeedback = enableFeedback
  }
}

public enum SettingAction: Equatable {
  case onAppear
  case leaveUsAReviewButtonTapped
  case binding(BindingAction<SettingState>)
  case stepperChanged(Int)
}

public struct SettingEnvironment {
  public var build: Build
  public var applicationClient: UIApplicationClient
  public var userDefaultsClient: UserDefaultsClient

  public init(
    build: Build,
    applicationClient: UIApplicationClient,
    userDefaultsClient: UserDefaultsClient
  ) {
    self.build = build
    self.applicationClient = applicationClient
    self.userDefaultsClient = userDefaultsClient
  }

  static let noop = Self(
    build: .noop,
    applicationClient: .noop,
    userDefaultsClient: .noop
  )
}

public let settingReducer = Reducer<SettingState, SettingAction, SettingEnvironment> {
  state, action, environment in
  switch action {
  case .onAppear:
    state.build = environment.build
    state.enableFeedback = environment.userDefaultsClient.hasCalculatorButtonTappedFeedback
    return .none
  case .leaveUsAReviewButtonTapped:
    return environment.applicationClient
      .open(
        URL(string: "https://apps.apple.com/jp/app/id1525626543?mt=8&action=write-review")!, [:]
      )
      .fireAndForget()
  case .binding(\.enableFeedback):
    state.enableFeedback = !state.enableFeedback
    return environment.userDefaultsClient
      .setHasCalculatorButtonTappedFeedback(state.enableFeedback)
      .fireAndForget()
  case .binding:
    return .none
  case let .stepperChanged(count):
    state.portraitCount = count
    return .none
  }
}
