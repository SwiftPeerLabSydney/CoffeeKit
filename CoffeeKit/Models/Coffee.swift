//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import Foundation

struct Coffee: Codable {
    let id: String
    let name: String
}

extension Coffee: Hashable {}
