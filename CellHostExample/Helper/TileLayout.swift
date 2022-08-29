//
//  TileLayout.swift
//  CellHostExample
//
//  Created by Vladimir Shutyuk on 29.08.2022.
//

import UIKit

enum TileLayout {
  case two(CGFloat)
  case three(CGFloat)
  case four(CGFloat)
  case five(CGFloat)
  case six(CGFloat)
}

extension TileLayout {
  static func make(with availableWidth: CGFloat) -> TileLayout {
    if availableWidth > 1000 {
      return .six(availableWidth)
    } else if availableWidth > 800 {
      return .five(availableWidth)
    } else if availableWidth > 640 {
      return .four(availableWidth)
    } else if availableWidth > 320 {
      return .three(availableWidth)
    } else {
      return .two(availableWidth)
    }
  }
}

extension TileLayout {

    var itemWidth: CGFloat {
        var effectiveWidth: CGFloat
        switch self {
        case .two(let width),
                .three(let width),
                .four(let width),
                .five(let width),
                .six(let width):
            effectiveWidth = width
        }
        effectiveWidth -= (sectionXInset * 2)
        if numColumns > 1 {
            effectiveWidth -= CGFloat(numColumns - 1) * interItemSpacing
        }
        let itemWidth = effectiveWidth / CGFloat(numColumns)
        return itemWidth
    }

    var numColumns: Int {
        switch self {
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        case .five:
            return 5
        case .six:
            return 6
        }
    }

    var interItemSpacing: CGFloat {
        switch self {
        case .two:
            return 16
        case .three:
            return 16
        default:
            return 32
        }
    }

    var sectionXInset: CGFloat {
        interItemSpacing
    }

    var interGroupSpacing: CGFloat {
        interItemSpacing
    }

    var sectionTopInset: CGFloat {
        interItemSpacing
    }

    var sectionBottomInset: CGFloat {
        interItemSpacing
    }

    var headerHeight: CGFloat {
        32
    }
}
