//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import SwiftUI

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
                Text("Coffees")
            }
            Text("Hello World")
                .tabItem {
                    Image(systemName: "0.square")
                    Text("About")
            }
        }
    }
}
