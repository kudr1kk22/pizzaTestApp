//
//  ModelBuilder.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 3.04.23.
//

import UIKit

protocol Builder {
  static func createMenuModule() -> UIViewController
}

final class ModelBuilder: Builder {

  static func createMenuModule() -> UIViewController {
    let view = MenuViewController()
    let networkService = NetworkService()
    let presenter = MenuPresenter(view: view, networkService: networkService)
    view.presenter = presenter
    return view
  }


}
