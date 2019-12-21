//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import SwiftUI

struct CoffeeGridView: View {
    var body: some View {
        VStack {
            HStack {
                CoffeeDiagramView(contents: espressoContent)
                CoffeeDiagramView(contents: macchiatoContent)
                CoffeeDiagramView(contents: conPannaContent)
            }
            .padding(10)
            HStack {
                CoffeeDiagramView(contents: caffeLatteContent)
                CoffeeDiagramView(contents: flatCoffeeContent)
                CoffeeDiagramView(contents: caffeBreveContent)
            }
            .padding(10)
            HStack {
                CoffeeDiagramView(contents: cappuccinoContent)
                CoffeeDiagramView(contents: cafeMochaContent)
                CoffeeDiagramView(contents: americanoContent)
            }
            .padding(10)
            HStack {
                CoffeeDiagramView(contents: latteMacchiato)
                CoffeeDiagramView(contents: redEyeContent)
                CoffeeDiagramView(contents: cafeAuLaitContent)
            }
            .padding(10)
        }
    }
}

struct CoffeeGridView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeGridView()
    }
}
