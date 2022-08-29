//
//  ItemCVCell.swift
//  CellHostExample
//
//  Created by Vladimir Shutyuk on 29.08.2022.
//

import UIKit
import SwiftUI

final class ItemCVCell: UICollectionViewCell {
  private var hostingController: UIHostingController<ItemView>?

  func setup(with item: Item, parent: UIViewController) {
    let itemView = ItemView(item: item)
    if let hostingController = hostingController {
      hostingController.rootView = itemView
      hostingController.view.layoutIfNeeded()
    } else {
      let hostingController = UIHostingController(rootView: itemView)
      parent.addChild(hostingController)
      hostingController.didMove(toParent: parent)
      hostingController.view.frame = contentView.bounds
      contentView.addSubview(hostingController.view)
      self.hostingController = hostingController
    }
  }

  deinit {
    hostingController?.willMove(toParent: nil)
    hostingController?.view.removeFromSuperview()
    hostingController?.removeFromParent()
    print("💀 \(type(of: self)) dead")
  }
}
