//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import SwiftUI

struct CoffeeStepView: View {
  // which coffee we are showing a step of
  var coffee: Coffee
  /// which PreparationStep is this view showing - some manager of the multi-step process should be changing this (next/previous buttons?)
  /// should this be an observable, being changed externally and view refreshes (rather than creating new view for different step ?)
  var stepIndex: Int

  var body: some View {
    // we want some indent from screen edges
    HStack {
      Spacer()

      VStack {
        Text(NSLocalizedString(coffee.name, comment: "must have key:value to match data.json"))
        Text("Step \(stepIndex+1)")

        Spacer()

        // optional image view IF a URL is specified. Note, can't do this with if inside View builder
        coffee.steps[stepIndex].imageUrlString.map({
          ImageView(withURL: $0)
        })

        Text(coffee.steps[stepIndex].instruction)

        // optional UX element, IF there is a resourceUrlString
        coffee.steps[stepIndex].resourceUrlString.map({_ in
          VStack {
            Spacer()
            // probably should be a NavigationLink, tapping goes to View probably wrapping a WKWebView
            Text("More info >")
              .foregroundColor(.blue)
          }
        })

        // optional helper timer IF there is a non-zero duration
      }
      Spacer()
    }
  }
}

#if DEBUG
struct CoffeeStepView_Previews: PreviewProvider {
  // test coffee from model Coffee.swift
  static var previews: some View {
    CoffeeStepView(coffee: testCoffeeDebug,
                   stepIndex: 1)
      .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
      .previewDisplayName("iPhone 8")
//      .environment(\.sizeCategory, .extraExtraExtraLarge)
      // set the local language, can be simple ISO 639-1 2-char codes like "ko" == korean, or more-specialised language ID like "en-AU" for English in Australia
      .environment(\.locale, .init(identifier: "ko"))
  }
}
#endif
