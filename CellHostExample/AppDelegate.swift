//
//  AppDelegate.swift
//  CellHostExample
//
//  Created by Vladimir Shutyuk on 24.08.2022.
//

import UIKit
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions
                   launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    let items = Just(Item.generate()).eraseToAnyPublisher()
    let layout = UICollectionViewLayout.makeTileLayout()
    let viewController = CollectionViewController(items: items,
                                                  layout: layout)
    window?.rootViewController = viewController
    return true
  }
}
