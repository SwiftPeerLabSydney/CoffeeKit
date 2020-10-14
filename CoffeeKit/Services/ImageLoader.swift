//  Copyright © 2020 SwiftPeerLabSydney. All rights reserved.
// adapted from http://www.gfrigerio.com/remote-images-in-swiftui/

import Foundation

class ImageLoader: ObservableObject {
  @Published var data: Data?

  init(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    // NC 20200307 this needs error handling etc
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data else { return }
      DispatchQueue.main.async {
        self.data = data
      }
    }
    task.resume()
  }
}
