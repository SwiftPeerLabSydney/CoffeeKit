//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import SwiftUI

struct CoffeeCell: View {
    let coffee: Coffee

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(coffee.name)
                    .font(.headline)
            }
            Spacer(minLength: 8)
        }
    }
}
