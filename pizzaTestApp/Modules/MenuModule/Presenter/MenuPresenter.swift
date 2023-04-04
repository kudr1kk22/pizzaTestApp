//
//  MenuPresenter.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 3.04.23.
//

import Foundation


final class MenuPresenter: MenuViewPresenterProtocol {

  var bannersModel: [BannerModel]?
  var categoriesModel: [CategoryModel]?
  var dishesModel: [DishesModel]?
  var sections = [SectionType]()

  weak var view: MenuViewProtocol?
  private let networkService: NetworkServiceProtocol

  init(view: MenuViewProtocol, networkService: NetworkServiceProtocol) {
    self.view = view
    self.networkService = networkService
    fetchData()
  }

  //MARK: - Fetch data

  func fetchData() {
    let group = DispatchGroup()

    group.enter()
    group.enter()
    group.enter()

    loadBanners() {
      group.leave()
    }

    loadCategories() {
      group.leave()
    }

    loadPizzaData {
      group.leave()
    }

    group.notify(queue: .main) { [weak self] in
      self?.configureModels()
      self?.view?.success()
    }
  }
}

//MARK: - Get banners

extension MenuPresenter {
  private func loadBanners(completion: @escaping () -> Void) {
    networkService.getBanners { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let model):
          self?.bannersModel = model
          completion()
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
}

//MARK: - Get categories

extension MenuPresenter {
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

//MARK: - Load pizza data

extension MenuPresenter {
  private func loadPizzaData(completion: @escaping () -> Void) {
    networkService.getPizzaData { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let model):
          self?.dishesModel = model
          completion()
        case .failure(let error):
          print(error.localizedDescription)
        }
      }
    }
  }
}

extension MenuPresenter {
  func configureModels() {
    if let bannersModel = bannersModel, let dishesModel = dishesModel {
      sections.append(.banners(models: bannersModel))
      sections.append(.dishes(models: dishesModel))
    }
  }
}

