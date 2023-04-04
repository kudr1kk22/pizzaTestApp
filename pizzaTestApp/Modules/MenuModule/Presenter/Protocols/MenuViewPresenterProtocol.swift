//
//  MenuViewPresenterProtocol.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 4.04.23.
//

import Foundation

protocol MenuViewPresenterProtocol: AnyObject {
  init(view: MenuViewProtocol, networkService: NetworkServiceProtocol)
  func fetchData()
  var bannersModel: [BannerModel]? { get }
  var categoriesModel: [CategoryModel]? { get }
  var dishesModel: [DishesModel]? { get }
  var sections: [SectionType] { get set }
}
