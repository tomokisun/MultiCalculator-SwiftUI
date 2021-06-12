//
//  ProductionApp.swift
//  Production
//
//  Created by 築山朋紀 on 2021/06/12.
//

import SwiftUI
import CalculatorFeature

@main
struct ProductionApp: App {
  var body: some Scene {
    WindowGroup {
      CalculatorView(
        store: .init(
          initialState: .init(),
          reducer: calculatorReducer,
          environment: .init()
        )
      )
    }
  }
}
