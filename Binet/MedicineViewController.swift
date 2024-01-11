//
//  ViewController.swift
//  Binet
//
//  Created by Ravil on 11.01.2024.
//

import UIKit

final class MedicineViewController: UIViewController {
    
    var drugs: [Drug] = []
    private var isSearchActive: Bool = false
    private var filteredDrugs: [Drug] = []
    let sections: [Medicine] = [.medicine]
    
    // MARK: - UI
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MedicineCell.self, forCellWithReuseIdentifier: MedicineCell.reuseID)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
        loadDrugsData()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.addSubview(collectionView)
        view.backgroundColor = .white
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - Setup Navigation Bar
    
    private func setupNavigationBar() {
        let leftImage = UIImage(named: "left.pdf")
        let leftBarButtonItem = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let titleLabel = UILabel()
        titleLabel.text = "Болезни"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "SFProDisplay-SemiBold", size: 17)
        navigationItem.titleView = titleLabel
        
        let searchImage = UIImage(named: "search.pdf")
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(searchBarButtonTapped))
        navigationItem.rightBarButtonItem = searchBarButtonItem
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(named: "greenCustom")
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    @objc func leftBarButtonTapped() {
        print("arrow")
    }

    @objc func searchBarButtonTapped() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Найти препараты"
        searchBar.delegate = self
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Найти препараты"
        
        present(searchController, animated: true, completion: nil)
    }
    
    // MARK: - Load Credit Data
    
    private func loadDrugsData() {
        let drugService = DrugService()
        drugService.fetchDrugs { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let drugs):
                    self?.drugs = drugs
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print("Ошибка: \(error)")
                }
            }
        }
    }
    
    // MARK: - Create Layout
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            let section = self?.sections[sectionIndex] ?? .medicine
            switch section {
            case .medicine:
                return self?.medicineSectionLayout()
            }
        }
    }
    
    // MARK: - Medicine Section Layout
    
    func medicineSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .absolute(296)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(296)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item, item]
        )
        
        group.interItemSpacing = .fixed(15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 15,
            trailing: 16
        )
        section.boundarySupplementaryItems = [supplementaryHeaderItem()]
        return section
    }
    
    // MARK: - Supplementary Header Item
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(43)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .topLeading
        )
    }
}

extension MedicineViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .medicine:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MedicineCell.reuseID,
                for: indexPath
            ) as? MedicineCell else {
                fatalError("Could not cast to MedicineCell")
            }
            let drug = isSearchActive ? filteredDrugs[indexPath.row] : drugs[indexPath.row]
            cell.configure(with: drug)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearchActive ? filteredDrugs.count : drugs.count
    }
}

extension MedicineViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchActive = !searchText.isEmpty
        filteredDrugs = isSearchActive ? drugs.filter { $0.name.localizedCaseInsensitiveContains(searchText) } : drugs
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearchActive = false
        filteredDrugs = drugs
        collectionView.reloadData()
    }
}
