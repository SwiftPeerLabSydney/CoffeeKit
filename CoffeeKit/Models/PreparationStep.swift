//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import Foundation

/// data about one step in making coffee
struct PreparationStep: Codable {
    /// steps are presented sorted by order i.e. they are sequential, not a set
    let order: Int
    /// if present has URL for some image (thumbnail etc) of what this step looks like
    let imageUrlString: String?
    /// string description (how will we handle localization of this?) for this step.
    let instruction: String
    /// time for this step in seconds. Does this really need a non-integer type ?
    let duration: Double
    /// if present, URL links to more info such as a more detail webpage or a video..  probably in a WKWebview inside a UIViewRepresentable
    let resourceUrlString: String?
}
