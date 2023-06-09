//
//  ModelBuilder.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 3.04.23.
//

import UIKit

final class ModelBuilder: Builder {

  static func createMenuModule() -> UIViewController {
    let view = MenuViewController()
    let networkService = NetworkService()
    let presenter = MenuPresenter(view: view,
                                  networkService: networkService)
    view.presenter = presenter
    return view
  }

  static func createTabBar() -> UITabBarController {
      let view = TabBarViewController()
      let presenter = TabBarPresenter(view: view)
      view.presenter = presenter
      return view
  }

  static func createCollectionViewCellModule(for indexPath: IndexPath, in collectionView: UICollectionView, kind: String) -> UICollectionReusableView {
    guard let categoryCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "\(CategoriesCollectionView.self)", for: indexPath) as? CategoriesCollectionView else { return UICollectionReusableView() }

    let networkService = NetworkService()
    let presenter = CategoriesPresenter(view: categoryCell,
                                        networkService: networkService)
    categoryCell.presenter = presenter
    
    return categoryCell
  }


}
