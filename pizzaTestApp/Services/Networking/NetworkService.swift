//
//  NetworkService.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 3.04.23.
//

import Foundation

private enum APIBaseURL {
  static let apiBaseURL = "https://pizza-and-desserts.p.rapidapi.com/pizzas"
  static let APIheaders = [
    // Use your API Key (only 20 request on mounth)
    "X-RapidAPI-Key": "292c3a4372msh8c7976db8649ee5p16aeecjsna9c24bba8a6e",
    "X-RapidAPI-Host": "pizza-and-desserts.p.rapidapi.com"
  ]
}

final class NetworkService: NetworkServiceProtocol {

  //MARK: - Get banners

  func getBanners(completion: @escaping (Result<[BannerModel], Error>) -> Void) {
    let models = self.prepareBannerModels()
    completion(.success(models))
  }

  //MARK: - Get Categories

  func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
    let models = self.prepareCategoryModels()
    completion(.success(models))
  }

  //MARK: - Get pizza data

  // Use this if you have API Key

  /*
   func getPizzaData(completion: @escaping (Result<[DishesModel], Error>) -> Void) {
   self.createRequest(with: URL(string: APIBaseURL.apiBaseURL), type: .GET, headers: APIBaseURL.APIheaders) { request in
   let task = URLSession.shared.dataTask(with: request) { data, _, error in
   guard let data = data, error == nil else { return }
   do {
   let result = try JSONDecoder().decode([DishesModel].self, from: data)
   completion(.success(result))
   }
   catch {
   completion(.failure(error))
   }
   }
   task.resume()
   }
   }
   */

  func getPizzaData(completion: @escaping (Result<[DishesModel], Error>) -> Void) {
    guard let path = Bundle.main.path(forResource: "JSON", ofType: "json") else {
      print("File not found")
      return
    }
    let url = URL(fileURLWithPath: path)
    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      let result = try decoder.decode([DishesModel].self, from: data)
      completion(.success(result))
    } catch {
      completion(.failure(error))
    }
  }

  //MARK: - Prepare Models

  private func prepareBannerModels() -> [BannerModel] {
    let models = [
      BannerModel(imageURL: "banner1"),
      BannerModel(imageURL: "banner2")
    ]
    return models
  }

  func prepareCategoryModels() -> [CategoryModel] {
      let models = [
        CategoryModel.pizza,
        CategoryModel.combo,
        CategoryModel.desserts,
        CategoryModel.beverages
      ]
      return models
    }
}

//MARK: - Create Request

extension NetworkService {
  private func createRequest(with url: URL?, type: HTTPMethod, headers: [String: String], completion: @escaping (URLRequest) -> Void) {
          guard let apiURL = url else { return }
          var request = URLRequest(url: apiURL)
          request.httpMethod = type.rawValue
          request.allHTTPHeaderFields = headers
          request.timeoutInterval = 30
          completion(request)
      }
}


