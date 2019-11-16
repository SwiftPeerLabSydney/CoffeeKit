//  Copyright © 2019 SwiftPeerLabSydney. All rights reserved.

import Foundation

struct LocalDataService {
    static func data() -> [Coffee]? {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return nil
        }
        do {
            let url = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            let response = try JSONDecoder().decode(CoffeeResponse.self, from: data)
            return response.coffees
        } catch {
            return nil
        }
    }
}
