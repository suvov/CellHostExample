//
//  ItemView.swift
//  CellHostExample
//
//  Created by Vladimir Shutyuk on 29.08.2022.
//

import SwiftUI

struct ItemView: View {
  let item: Item

  var body: some View {
    ZStack {
      Circle()
        .foregroundColor(Color(item.color))
      Text(item.title)
    }
  }
}

struct CollectionItemView_Previews: PreviewProvider {
  static var previews: some View {
    ItemView(item: .init(title: "1", color: .purple))
      .padding()
      .frame(width: 200, height: 200)
      .previewLayout(.sizeThatFits)
  }
}
