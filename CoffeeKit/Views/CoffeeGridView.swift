//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import SwiftUI

struct CoffeeGridView: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                CoffeeDiagramView(title: "Espresso", contents: cappuccinoContent)
                    .frame(width: geometry.size.width, height: geometry.size.width)
                
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        CoffeeDiagramView(title: "Espresso", contents: espressoContent)
                            .frame(width: geometry.size.width / 3, height: geometry.size.height / 4)
                        CoffeeDiagramView(title: "Macchiato", contents: macchiatoContent)
                            .frame(width: geometry.size.width / 3, height: geometry.size.height / 4)
                        CoffeeDiagramView(title: "Con Panna", contents: conPannaContent)
                            .frame(width: geometry.size.width / 3, height: geometry.size.height / 4)
                    }
                    HStack(spacing: 0) {
                        CoffeeDiagramView(title: "Caffe Latte", contents: caffeLatteContent)
                            .frame(width: geometry.size.width / 4, height: geometry.size.width / 3)
                        CoffeeDiagramView(title: "Flat Coffee", contents: flatCoffeeContent)
                            .frame(width: geometry.size.width / 4, height: geometry.size.width / 3)
                        CoffeeDiagramView(title: "Caffe Breve", contents: caffeBreveContent)
                            .frame(width: geometry.size.width / 4, height: geometry.size.width / 3)
                    }
                    HStack(spacing: 0) {
                        CoffeeDiagramView(title: "Cappuccino", contents: cappuccinoContent)
                            .frame(width: geometry.size.width / 3, height: geometry.size.width / 4)
                        CoffeeDiagramView(title: "Cafe Mocha", contents: cafeMochaContent)
                            .frame(width: geometry.size.width / 3, height: geometry.size.width / 4)
                        CoffeeDiagramView(title: "Americano", contents: americanoContent)
                            .frame(width: geometry.size.width / 3, height: geometry.size.width / 4)
                    }
                    HStack(spacing: 0) {
                        CoffeeDiagramView(title: "Latte Macchiato", contents: latteMacchiato)
                            .frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
                        CoffeeDiagramView(title: "Red Eye", contents: redEyeContent)
                            .frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
                        CoffeeDiagramView(title: "Cafe Au Lait", contents: cafeAuLaitContent)
                            .frame(width: geometry.size.width / 3, height: geometry.size.width / 3)
                    }
                }
            }
        }
    }
}

struct CoffeeGridView_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeGridView()
    }
}
