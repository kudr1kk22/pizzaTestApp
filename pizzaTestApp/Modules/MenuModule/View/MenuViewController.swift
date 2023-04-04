//
//  MenuViewController.swift
//  pizzaTestApp
//
//  Created by Eugene Kudritsky on 2.04.23.
//

import UIKit

final class MenuViewController: UIViewController {

  //MARK: - Properties

  private var collectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout())

  var presenter: MenuViewPresenterProtocol!

  //MARK: - Initialization

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    registerCells()
    setNavigationItem()
    setConstraints()
  }

  private func configureUI(){
    view.backgroundColor = .systemBackground
    view.addSubview(collectionView)
  }
}

//MARK: - MenuViewProtocol

extension MenuViewController: MenuViewProtocol {
  func success() {
    collectionView.reloadData()
  }

  func failure(error: Error) {
    print(error.localizedDescription)
  }
}

//MARK: - Scroll delegate

extension MenuViewController: ScrollDelegate {
  func didSelectCategory(_ index: Int) {
    let indexPath = IndexPath(item: index, section: 1)
    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
  }
}

//MARK: - Navigation Bar

extension MenuViewController {
  private func setNavigationItem() {
    makeLeftBarButtonItem()
    navigationController?.navigationBar.barTintColor = Colors.topBackground
    navigationController?.navigationBar.shadowImage = UIImage()
  }

  private func makeLeftBarButtonItem() {
    let button = UIButton(type: .system)
    button.setTitle("Москва", for: .normal)
    button.tintColor = Colors.cityNavigationName
    button.titleLabel?.font = UIFont(name: Fonts.mainFontMedium, size: 17.0)
    button.setImage(UIImage(named: "dropDownIcon"), for: .normal)
    button.semanticContentAttribute = .forceRightToLeft
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
  }

}

//MARK: - Create CollectionViewCell

extension MenuViewController {
  private func registerCells() {

    let layout =  UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
      return self.createSectionLayout(section: sectionIndex)
    }

    collectionView.dataSource = self
    collectionView.backgroundColor = Colors.topBackground
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.collectionViewLayout = layout

    collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "\(BannerCell.self)")

    collectionView.register(DishesCell.self, forCellWithReuseIdentifier: "\(DishesCell.self)")

    collectionView.register(CategoriesCollectionView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(CategoriesCollectionView.self)")
  }
}

//MARK: - UICollectionViewDataSource

extension MenuViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return presenter.sections.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    let type = presenter.sections[section]
    switch type {
    case .banners(let models):
      return models.count
    case .dishes(let models):
      return models.count
    }
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    let type = presenter.sections[indexPath.section]

    switch type {

    case .banners(let models):
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(BannerCell.self)", for: indexPath) as? BannerCell else { return UICollectionViewCell() }

      let banner = models[indexPath.row]
      cell.configureCell(model: banner)

      return cell
    case .dishes(let models):
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DishesCell.self)", for: indexPath) as? DishesCell else { return UICollectionViewCell() }
      let dishes = models[indexPath.row]
      if indexPath.item == 0 {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        cell.layer.mask = maskLayer
      }
      
      cell.configureCell(model: dishes)

      return cell
    }
  }

  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let section = indexPath.section

    guard kind == UICollectionView.elementKindSectionHeader && section == 1 else { return UICollectionReusableView() }

    let cell = ModelBuilder.createCollectionViewCellModule(for: indexPath, in: collectionView, kind: kind) as! CategoriesCollectionView
    cell.delegate = self
    
    return cell
  }
}

//MARK: - Constraints

extension MenuViewController {
  private func setConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: view.topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

//MARK: - Section Layout

extension MenuViewController {

  func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
    let item = NSCollectionLayoutBoundarySupplementaryItem(
      layoutSize: NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .absolute(80.0)
      ),
      elementKind: UICollectionView.elementKindSectionHeader,
      alignment: .top
    )
    item.pinToVisibleBounds = true
    let supplementaryViews = [item]

    switch section {
    case 0:
      // Item
      let item = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)
        )
      )

      let horizontalGroup = NSCollectionLayoutGroup.horizontal(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(0.85),
          heightDimension: .fractionalHeight(0.14)
        ),
        subitem: item,
        count: 1
      )

      horizontalGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0)

      // Section
      let section = NSCollectionLayoutSection(group: horizontalGroup)
      section.orthogonalScrollingBehavior = .paging
      section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 16)

      return section
    case 1:
      // Item
      let item = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .fractionalHeight(1)
        )
      )

      let verticalGroup = NSCollectionLayoutGroup.vertical(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1),
          heightDimension: .fractionalHeight(0.2)
        ),
        subitem: item,
        count: 1
      )

      // Section
      let section = NSCollectionLayoutSection(group: verticalGroup)
      section.boundarySupplementaryItems = supplementaryViews

      return section

    case 2:
      // Item
      let item = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)
        )
      )

      item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

      let group = NSCollectionLayoutGroup.vertical(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .absolute(120)
        ),
        subitem: item,
        count: 1
      )

      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
      return section
    default:
      // Item
      let item = NSCollectionLayoutItem(
        layoutSize: NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .fractionalHeight(1.0)
        )
      )

      item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(0.1),
        heightDimension: .absolute(40.0))

      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: groupSize,
        subitem: item,
        count: 1)

      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous

      section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0)
      return section
    }
  }
}
