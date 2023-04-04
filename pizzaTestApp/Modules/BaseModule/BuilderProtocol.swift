//
//  BuilderProtocol.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 4.04.23.
//

import UIKit

protocol Builder {
  static func createMenuModule() -> UIViewController
  static func createCollectionViewCellModule(for indexPath: IndexPath, in collectionView: UICollectionView, kind: String) -> UICollectionReusableView
  static func createTabBar() -> UITabBarController 
}
