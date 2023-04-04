//
//  DishesModel.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 3.04.23.
//

import Foundation

struct DishesModel: Decodable {
  let name: String
  let price: Int
  let description: String
  let imageURL: String

  enum CodingKeys: String, CodingKey {
    case name
    case price
    case description
    case imageURL = "img"
    }
}
