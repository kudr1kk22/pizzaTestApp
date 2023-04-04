//
//  TabBarViewController.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 2.04.23.
//

import UIKit

final class TabBarViewController: UITabBarController {

  // MARK: - Properties

  var presenter: TabBarPresenterProtocol!

  // MARK: - Life Cycle

  override func viewDidLoad() {
      super.viewDidLoad()
      presenter = TabBarPresenter(view: self)
      presenter?.createTabBarItems()
      presenter?.setTabBarColors()
  }
  
  func setViewControllers(_ viewControllers: [UIViewController]) {
      setViewControllers(viewControllers, animated: false)
  }

}

// MARK: - TabBarViewProtocol

extension TabBarViewController: TabBarViewProtocol {
  func setTabBarItems(_ items: [TabBarItemModel]) {
    let viewControllers = items.enumerated().map { index, item -> UIViewController in
      let viewController = UIViewController()
      viewController.title = item.title
      viewController.tabBarItem = UITabBarItem(title: item.title, image: item.image, tag: index)
      return viewController
    }
    setViewControllers(viewControllers, animated: false)
  }
}
