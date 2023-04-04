//
//  UIView+MakeRounded.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 3.04.23.
//

import UIKit

extension UIView {
  func makeRounded(radius: Double) {
    layer.cornerRadius = radius
    clipsToBounds = true
  }

  func makeRounded() {
    layer.cornerRadius = self.frame.height / 2
    clipsToBounds = true
  }  
}
