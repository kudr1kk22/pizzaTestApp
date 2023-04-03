//
//  TabBarViewController.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 2.04.23.
//

import UIKit

private enum TabBarConstants {
  static let menu = "Меню"
  static let contacts = "Контакты"
  static let profile = "Профиль"
  static let cart = "Корзина"
}

final class TabBarViewController: UITabBarController {

  //MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    createTabBar()
  }

  //MARK: - Create TabBar

  private func createTabBar() {

    let menuVC = ModelBuilder.createMenuModule()
    let contactsVC = UIViewController()
    let profileVC = UIViewController()
    let cartVC = UIViewController()

    setTabBarColors()

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
    
    self.setViewControllers(viewControllers, animated: false)
  }
}

//MARK: - Set Tabbar Colors

extension TabBarViewController {
  private func setTabBarColors() {
    tabBar.unselectedItemTintColor = Colors.unSelectedTabBarItem
    tabBar.tintColor = Colors.selectedTabBarItem
    tabBar.barTintColor = .white
  }
}
