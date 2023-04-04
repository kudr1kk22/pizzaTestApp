//
//  CategoriesCollectionView.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 3.04.23.
//

import UIKit

protocol ScrollDelegate: AnyObject {
    func didSelectCategory(_ index: Int)
}

final class CategoriesCollectionView: UICollectionReusableView {

  //MARK: - Properties

  private var collectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout())

  var presenter: CategoriesViewPresenterProtocol!
  weak var delegate: ScrollDelegate?

  //MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)

    collectionView.dataSource = self
    addSubview(collectionView)
    registerCells()

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    collectionView.frame = bounds
  }

}

extension CategoriesCollectionView {
  private func registerCells() {

    let layout =  UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
      return self.createSectionLayout(section: sectionIndex)
    }

    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = Colors.topBackground
    collectionView.allowsMultipleSelection = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.collectionViewLayout = layout

    collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: "\(CategoriesCell.self)")

  }
}

extension CategoriesCollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return presenter.categoriesModel?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoriesCell.self)", for: indexPath) as? CategoriesCell else { return UICollectionViewCell() }

    if let category = presenter.categoriesModel?[indexPath.row] {
      cell.configureCell(model: category)
      if presenter.selectedIndex == indexPath.row
      {
        cell.configureSelectedAppearance()
      } else {
        cell.configureStandartAppearance()
      }
      return cell
    } else {
      return UICollectionViewCell()
    }

  }


}

extension CategoriesCollectionView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    presenter.selectedIndex = indexPath.row
    categoryTapped(index: presenter.selectedIndex)
    collectionView.reloadData()
     }
}

extension CategoriesCollectionView: CategoriesViewProtocol {
  func success() {
    collectionView.reloadData()
  }

  func failure(error: Error) {
    print(error.localizedDescription)
  }
}

//MARK: - Scroll delegate

extension CategoriesCollectionView {
  func categoryTapped(index: Int) {
        delegate?.didSelectCategory(index)
    }
}

//MARK: - Section Layout

extension CategoriesCollectionView {

  func createSectionLayout(section: Int) -> NSCollectionLayoutSection {

    switch section {
    default:
      // Item
      let item = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)
        )
      )

      item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)

      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(0.27),
        heightDimension: .absolute(40.0))

      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: groupSize,
        subitem: item,
        count: 1)

      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous

      section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 0)
      return section
    }
  }
}
