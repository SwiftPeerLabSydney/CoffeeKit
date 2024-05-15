//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import Foundation

struct Coffee: Codable {
    let id: String
    let name: String
    let grind: Grind
    let ingredients: [Ingredient]
    let equipment: Equipment
    let steps: [PreparationStep]
}

extension Coffee: Hashable {
    static func == (lhs: Coffee, rhs: Coffee) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

#if DEBUG
// this is a subset of an entry from the data.json

let testCoffees = LocalDataService.data()

// lets try for two which should be in the data.json, with default fallback so not optional in previews
let testCoffeeStovetop: Coffee = testCoffees?.first(where: {$0.name == "Stovetop Espresso"}) ?? Coffee(id: "99",
                                                                                                       name: "Espresso",
                                                                                                       grind: .fine,
                                                                                                       ingredients: [],
                                                                                                       equipment: Equipment(filter: nil,
                                                                                                                            machine: "Espresso machine",
                                                                                                                            tamper: true),
                                                                                                       steps: [PreparationStep(order: 9,
                                                                                                                               imageUrlString: nil,
                                                                                                                               instruction: "some words for machine expresso",
                                                                                                                               duration: 0.0,
                                                                                                                               resourceUrlString: nil)]
)

// and a guaranteed one as created here, independent of data.json
let testCoffeeDebug = Coffee(id: "99",
                             name: "Espresso",
                             grind: .fine,
                             ingredients: [Ingredient(name: "beans",
                                                      quantity: 30.0,
                                                      metric: "grams"),
                                           Ingredient(name: "water",
                                                      quantity: 60.0,
                                                      metric: "millilitres")],
                             equipment: Equipment(filter: nil,
                                                  machine: "Espresso pot",
                                                  tamper: true),
                             steps: [PreparationStep(order: 0,
                                                     imageUrlString: "https://placekitten.com/200/200",
                                                     instruction: "Remove the funnel from the base, fill the base with water to just below the safety valve.\n\nThe valve is a small fitting on the side of the lower part of the pot, usually attached by a hexagonal nut)",
                                                     duration: 120.0,
                                                     resourceUrlString: "https://www.youtube.com/watch?v=A8MFlzT07SU"),
                                     PreparationStep(order: 1,
                                                     imageUrlString: nil,
                                                     instruction: "Place the funnel into the base, and slightly overfill with coffee grounds",
                                                     duration: 0.0,
                                                     resourceUrlString: ""),
                                     PreparationStep(order: 2,
                                                     imageUrlString: "https://loremflickr.com/200/200/dog",
                                                     instruction: "Tamp down the coffee, wipe off any excess grounds, before screwing the top firmly onto the bottom",
                                                     duration: 0.0,
                                                     resourceUrlString: nil),
                                     PreparationStep(order: 3,
                                                     imageUrlString: "https://loremflickr.com/g/200/200/paris",
                                                     instruction: "Put on gentle heat, ensuring the handle is NOT in rising high heat",
                                                     duration: 0.0,
                                                     resourceUrlString: nil)])

#endif
