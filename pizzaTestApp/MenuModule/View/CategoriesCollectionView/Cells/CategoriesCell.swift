//
//  CategoriesCell.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 3.04.23.
//

import UIKit

final class CategoriesCell: UICollectionViewCell {

  //MARK: - Properties

  private let categoryLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: Fonts.mainFontRegular, size: 13.0)
    label.textAlignment = .center
    label.textColor = Colors.category
    return label
  }()

  override var isSelected: Bool {
      didSet {
          if isSelected {
            layer.backgroundColor = Colors.categoryBackground.cgColor
              layer.borderWidth = 0
              layer.cornerRadius = 20
            categoryLabel.textColor = Colors.categoryText
            categoryLabel.font = UIFont(name: Fonts.mainFontBold, size: 13.0)
          } else {
            layer.backgroundColor = .none
            layer.borderColor = Colors.category.cgColor
            layer.borderWidth = 1
            categoryLabel.textColor = Colors.category
            categoryLabel.font = UIFont(name: Fonts.mainFontRegular, size: 13.0)

          }
      }
  }

  //MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setContstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Configure UI

  private func configureUI() {
    self.addSubview(categoryLabel)
    layer.borderColor = Colors.category.cgColor
      layer.borderWidth = 1
      layer.cornerRadius = 20
  }

  func configureCell(model: CategoryModel) {
    categoryLabel.text = model.name
  }

  

}

//MARK: - Constraints

extension CategoriesCell {
  private func setContstraints() {
    NSLayoutConstraint.activate([
      categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
    ])
  }
}
