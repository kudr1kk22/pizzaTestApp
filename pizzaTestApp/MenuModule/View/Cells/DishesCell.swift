//
//  DishesCell.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 3.04.23.
//

import UIKit
import SDWebImage

final class DishesCell: UICollectionViewCell {

  //MARK: - Properties

  private let imageView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
  }()

  private let nameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.mainFontSemiBold, size: 17.0)
    label.textColor = Colors.namePizzaColor
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Fonts.mainFontRegular, size: 13.0)
    label.textColor = Colors.descriptionPizzaColor
    label.numberOfLines = 3
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private let separatorView: UIView = {
     let view = UIView()
     view.backgroundColor = Colors.separatorColor
     view.translatesAutoresizingMaskIntoConstraints = false
     return view
   }()

  //MARK: - Initialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
    setConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - layoutSubviews

  override func layoutSubviews() {
       super.layoutSubviews()
       imageView.makeRounded()
   }

  //MARK: - Configure UI

  private func configureUI() {
      [imageView, nameLabel, descriptionLabel, separatorView].forEach { contentView.addSubview($0) }
  }

  func configureCell(model: DishesModel) {
    nameLabel.text = model.name
    descriptionLabel.text = model.description
    if let imageURL = URL(string: model.imageURL) {
      imageView.sd_setImage(with: imageURL)
    }
  }
}

//MARK: - Constraints

extension DishesCell {
  private func setConstraints() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.0),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24.0),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
    ])

    NSLayoutConstraint.activate([
      
      nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 32.0),
      nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 32.0),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      nameLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor),
      nameLabel.heightAnchor.constraint(equalToConstant: 17.0)
    ])

    NSLayoutConstraint.activate([
      descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0),
      descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
      descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    ])

    NSLayoutConstraint.activate([
       separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
       separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
       separatorView.bottomAnchor.constraint(equalTo: bottomAnchor),
       separatorView.heightAnchor.constraint(equalToConstant: 1)
     ])

  }
}