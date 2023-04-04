//
//  BannerCell.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 3.04.23.
//

import UIKit

final class BannerCell: UICollectionViewCell {

  //MARK: - Properties

  private let imageView: UIImageView = {
    let image = UIImageView()
    image.makeRounded(radius: 5.0)
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
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

  //MARK: - Configure UI

  private func configureUI() {
    contentView.addSubview(imageView)
  }

  func configureCell(model: BannerModel) {
    let image = UIImage(named: model.imageURL)
    imageView.image = image
  }
  
}

//MARK: - Constraints

extension BannerCell {
  private func setConstraints() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
}


