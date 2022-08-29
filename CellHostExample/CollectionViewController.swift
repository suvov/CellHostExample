//
//  CollectionViewController.swift
//  CellHostExample
//
//  Created by Vladimir Shutyuk on 29.08.2022.
//

import UIKit
import Combine
import SwiftUI

final class CollectionViewController: UICollectionViewController {
  private let items: AnyPublisher<[Item], Never>
  private var datasource: UICollectionViewDiffableDataSource<String, Item>?
  private var subscriptions = Set<AnyCancellable>()

  init(items: AnyPublisher<[Item], Never>, layout: UICollectionViewLayout) {
    self.items = items
    super.init(collectionViewLayout: layout)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    setupDataSource()
    configureModel()
  }
}

private extension CollectionViewController {
  func configureView() {
    collectionView.backgroundColor = .systemBackground
    collectionView.alwaysBounceVertical = true
  }

  func setupDataSource() {
    if #available(iOS 16, *) {
      let registration = UICollectionView.CellRegistration<UICollectionViewCell, Item> { cell, indexPath, item in
        cell.contentConfiguration = UIHostingConfiguration {
          ItemView(item: item)
        }
      }
      datasource = UICollectionViewDiffableDataSource(
        collectionView: collectionView
      ) { (cv, ip, item) -> UICollectionViewCell? in
        cv.dequeueConfiguredReusableCell(using: registration, for: ip, item: item)
      }
    } else if #available(iOS 14, *) {
      let registration = UICollectionView.CellRegistration<ItemCVCell, Item> { cell, indexPath, item in
        cell.setup(with: item, parent: self)
      }
      datasource = UICollectionViewDiffableDataSource(
        collectionView: collectionView
      ) { (cv, ip, item) -> UICollectionViewCell? in
        cv.dequeueConfiguredReusableCell(using: registration, for: ip, item: item)
      }
    } else {
      collectionView.registerCellClass(ItemCVCell.self)
      datasource = UICollectionViewDiffableDataSource(
        collectionView: collectionView
      ) { (cv, ip, item) -> UICollectionViewCell? in
        let cell: ItemCVCell = cv.dequeueCell(for: ip)
        cell.setup(with: item, parent: self)
        return cell
      }
    }
    collectionView.dataSource = datasource
  }
  
  func configureModel() {
    items
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] items in
        var snapshot = NSDiffableDataSourceSnapshot<String, Item>()
        snapshot.appendSections(["Main"])
        snapshot.appendItems(items, toSection: "Main")
        self.datasource?.apply(snapshot)
      }
      .store(in: &subscriptions)
  }
}
