//
//  CategoryModel.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 3.04.23.
//

import Foundation

enum CategoryModel {
  case pizza
  case combo
  case desserts
  case beverages


  var title: String {
    switch self {
    case .pizza: return "Пицца"
    case .combo: return "Комбо"
    case .desserts: return "Дисерты"
    case .beverages: return "Напитки"
    }
  }

}
