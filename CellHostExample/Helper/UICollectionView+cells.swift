//
//  UICollectionView+cells.swift
//  CellHostExample
//
//  Created by Vladimir Shutyuk on 29.08.2022.
//

import UIKit

extension UICollectionView {
  func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
    guard let cell = dequeueReusableCell(
      withReuseIdentifier: T.reuseIdentifier, for: indexPath
    ) as? T else {
      fatalError("Register cell using registerCellClass(:)")
    }
    return cell
  }

  func registerCellClass(_ cellClass: UICollectionViewCell.Type) {
    register(cellClass.self, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
  }

  func dequeueView<T: UICollectionReusableView>(of kind: String, for indexPath: IndexPath) -> T {
    guard let view = dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: T.reuseIdentifier,
      for: indexPath
    ) as? T else {
      fatalError()
    }
    return view
  }

  func registerHeaderClass(_ viewClass: UICollectionReusableView.Type) {
    register(
      viewClass.self,
      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
      withReuseIdentifier: viewClass.reuseIdentifier
    )
  }
}

private extension UICollectionReusableView {
  static var reuseIdentifier: String {
    String(describing: Self.self)
  }
}
