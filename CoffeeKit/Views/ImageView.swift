// Copyright © 2020 SwiftPeerLabSydney. All rights reserved.
// adapted from http://www.gfrigerio.com/remote-images-in-swiftui/

import Foundation
import SwiftUI
import UIKit

struct ImageView: View {
  @ObservedObject var imageLoader: ImageLoader
  @State var image: UIImage = UIImage()
  let W, H: CGFloat
  let CM: ContentMode

  // the frame width/height

  init(withURL url: String,
       width: CGFloat = 200,
       height: CGFloat = 200,
       contentMode: ContentMode = .fit) {
    imageLoader = ImageLoader(urlString: url)
    W = width
    H = height
    CM = contentMode
  }

  var body: some View {
    VStack {
      Image(uiImage: imageLoader.data != nil ? UIImage(data: imageLoader.data!)! : UIImage())
      .resizable()
      .aspectRatio(contentMode: CM)
      .frame(width: W, height: H)
    }
  }
}

#if DEBUG
struct ImageView_Previews: PreviewProvider {
  // test image from model Coffee.swift
  static var previews: some View {
    ImageView(withURL: "https://placekitten.com/200/200")
      .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
      .previewDisplayName("iPhone 8")
      .border(Color.red, width: 1.0)}
}
#endif
