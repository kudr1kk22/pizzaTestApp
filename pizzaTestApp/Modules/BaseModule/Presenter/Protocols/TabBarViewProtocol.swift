//
//  TabBarViewProtocol.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 4.04.23.
//

import UIKit

protocol TabBarViewProtocol: AnyObject {
  func setTabBarItems(_ items: [TabBarItemModel])
  func setViewControllers(_ viewControllers: [UIViewController])
}
