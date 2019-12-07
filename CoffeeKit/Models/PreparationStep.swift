//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import Foundation

struct PreparationStep: Codable {
    let order: Int
    let imageUrlString: String?
    let instruction: String
    let duration: Double
    let resourceUrlString: String?
}
