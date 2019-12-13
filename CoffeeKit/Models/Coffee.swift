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
