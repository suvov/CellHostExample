//
//  UICollectionView+layout.swift
//  CellHostExample
//
//  Created by Vladimir Shutyuk on 29.08.2022.
//

import UIKit

extension UICollectionViewLayout {
  static func makeTileLayout() -> UICollectionViewLayout {
    UICollectionViewCompositionalLayout(sectionProvider: { (_, env) -> NSCollectionLayoutSection? in
      let layout = TileLayout.make(with: env.container.effectiveContentSize.width)
      let itemWidth = NSCollectionLayoutDimension.absolute(layout.itemWidth)
      let itemHeight = NSCollectionLayoutDimension.absolute(layout.itemWidth * 1.6)
      let itemSize = NSCollectionLayoutSize(
        widthDimension: itemWidth,
        heightDimension: itemHeight
      )
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1.0),
        heightDimension: itemHeight
      )
      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: groupSize,
        subitems: [item]
      )
      group.interItemSpacing = .fixed(layout.interItemSpacing)
      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = layout.interGroupSpacing
      section.contentInsets = NSDirectionalEdgeInsets(
        top: layout.sectionTopInset,
        leading: layout.sectionXInset,
        bottom: layout.sectionBottomInset,
        trailing: layout.sectionXInset
      )
      return section
    })
  }
}
