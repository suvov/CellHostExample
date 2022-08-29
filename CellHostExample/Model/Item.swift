//
//  Item.swift
//  CellHostExample
//
//  Created by Vladimir Shutyuk on 29.08.2022.
//

import UIKit

struct Item: Hashable {
  let title: String
  let color: UIColor
}

extension Item {
  static func generate(_ count: Int = 50) -> [Item] {
    let colors: [UIColor] = [.systemRed, .systemBlue, .systemGray,
                             .systemPink, .systemTeal, .systemBrown,
                             .systemGreen, .systemOrange, .systemPurple,
                             .systemYellow]
    var items = [Item]()
    for index in 0 ... count {
      items.append(.init(title: "\(index)", color: colors[index % colors.count]))
    }
    return items
  }
}
