//
//  CategoriesPresenter.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 3.04.23.
//

import Foundation

protocol CategoriesViewProtocol: AnyObject {
  func success()
  func failure(error: Error)
}

protocol CategoriesViewPresenterProtocol: AnyObject {
  init(view: CategoriesViewProtocol, networkService: NetworkServiceProtocol)
  func fetchData()
  var categoriesModel: [CategoryModel]? { get }
  var selectedIndex: Int { get set }
}

final class CategoriesPresenter: CategoriesViewPresenterProtocol {

  var categoriesModel: [CategoryModel]?
  var selectedIndex = Int()
  weak var view: CategoriesViewProtocol?
  private let networkService: NetworkServiceProtocol

  init(view: CategoriesViewProtocol, networkService: NetworkServiceProtocol) {
    self.view = view
    self.networkService = networkService
    fetchData()
  }

  //MARK: - Fetch data

  func fetchData() {
    let group = DispatchGroup()

    group.enter()

    loadCategories() {
      group.leave()
    }

    group.notify(queue: .main) { [weak self] in
      self?.view?.success()
    }
  }
}

//MARK: - Get categories

extension CategoriesPresenter {
  private func loadCategories(completion: @escaping () -> Void) {
    networkService.getCategories { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let model):
          self?.categoriesModel = model
          completion()
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
}

