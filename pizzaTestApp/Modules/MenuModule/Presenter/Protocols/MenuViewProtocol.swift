//
//  MenuViewProtocol.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 4.04.23.
//

import Foundation

protocol MenuViewProtocol: AnyObject {
  func success()
  func failure(error: Error)
}
