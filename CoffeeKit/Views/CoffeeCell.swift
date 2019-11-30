//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import SwiftUI

struct CoffeeCell: View {
    let coffee: Coffee

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
              Text(NSLocalizedString(coffee.name, comment: "must have key:value to match data.json"))
                    .font(.headline)
            }
            Spacer(minLength: 8)
        }
    }
}
