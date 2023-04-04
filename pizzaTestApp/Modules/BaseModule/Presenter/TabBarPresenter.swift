//
//  TabBarPresenter.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 4.04.23.
//

import UIKit

private enum TabBarConstants {
  static let menu = "Меню"
  static let contacts = "Контакты"
  static let profile = "Профиль"
  static let cart = "Корзина"
}

class TabBarPresenter: TabBarPresenterProtocol {

  // MARK: - Properties

  weak var view: TabBarViewProtocol?

  //MARK: - Init

  init(view: TabBarViewProtocol) {
    self.view = view
  }

  // MARK: - TabBarPresenterProtocol

  func createTabBarItems() {
      let menuVC = ModelBuilder.createMenuModule()
      let contactsVC = UIViewController()
      let profileVC = UIViewController()
      let cartVC = UIViewController()

      menuVC.tabBarItem = UITabBarItem(title: TabBarConstants.menu,
                                       image: UIImage(named: "menuIcon"),
                                       tag: 0)
      contactsVC.tabBarItem = UITabBarItem(title: TabBarConstants.contacts,
                                           image: UIImage(named: "contactsIcon"),
                                           tag: 1)
      profileVC.tabBarItem = UITabBarItem(title: TabBarConstants.profile,
                                          image: UIImage(named: "profileIcon"),
                                          tag: 2)
      cartVC.tabBarItem = UITabBarItem(title: TabBarConstants.cart,
                                       image: UIImage(named: "cartIcon"),
                                       tag: 3)

      let menuVCnavigationController = UINavigationController(rootViewController: menuVC)
      let contactsVCnavigationController = UINavigationController(rootViewController: contactsVC)
      let profileVCnavigationController = UINavigationController(rootViewController: profileVC)
      let cartVCnavigationController = UINavigationController(rootViewController: cartVC)

      let viewControllers = [
        menuVCnavigationController,
        contactsVCnavigationController,
        profileVCnavigationController,
        cartVCnavigationController]

      view?.setViewControllers(viewControllers)
  }

  func setTabBarColors() {
    guard let view = view as? TabBarViewController else { return }
    view.tabBar.unselectedItemTintColor = Colors.unSelectedTabBarItem
    view.tabBar.tintColor = Colors.selectedTabBarItem
    view.tabBar.barTintColor = .white
  }
}
