//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import SwiftUI

let coffeesTabString: LocalizedStringKey = "Coffees"
let aboutTabString: LocalizedStringKey = "About"

// as this next one should NOT ship, there should be unit test that the value is not the key
let aboutTextString: LocalizedStringKey = "About the CoffeeKit content"

struct ContentView: View {
    let coffees: [Coffee]

    var body: some View {
        TabView {
            List {
                ForEach(coffees, id: \.self ) { coffee in
                    CoffeeCell(coffee: coffee)
                }
            }
            .tabItem {
                Image(systemName: "0.circle")
                Text(coffeesTabString)
            }
            Text(aboutTextString)
                .tabItem {
                    Image(systemName: "0.square")
                    Text(aboutTabString)
            }
        }
    }
}
