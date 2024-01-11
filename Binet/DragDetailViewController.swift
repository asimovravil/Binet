//
//  DragDetailViewController.swift
//  Binet
//
//  Created by Ravil on 11.01.2024.
//

import UIKit

class DragDetailViewController: UIViewController {

    // MARK: - UI
    
    private lazy var detailLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var detailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "detailImage")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var favouriteImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "favourite")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var detailTitle: UILabel = {
        let label = UILabel()
        label.text = "ДВД Шанс, КС"
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailSubTitle: UILabel = {
        let label = UILabel()
        label.text = "Двухкомпонентный протравитель семян зерновых культур."
        label.textAlignment = .left
        label.textColor = UIColor(named: "grayCustom")
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "buttonBuy"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [detailLogo, detailImage, favouriteImage, detailTitle, detailSubTitle, detailButton].forEach {
            view.addSubview($0)
        }
        view.backgroundColor = .white
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            detailImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            detailImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailImage.heightAnchor.constraint(equalToConstant: 183),
            
            detailLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            detailLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailLogo.heightAnchor.constraint(equalToConstant: 32),
            detailLogo.widthAnchor.constraint(equalToConstant: 32),
            
            favouriteImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            favouriteImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -34),
            favouriteImage.heightAnchor.constraint(equalToConstant: 32),
            favouriteImage.widthAnchor.constraint(equalToConstant: 32),
            
            detailTitle.topAnchor.constraint(equalTo: detailImage.bottomAnchor, constant: 32),
            detailTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),

            detailSubTitle.topAnchor.constraint(equalTo: detailTitle.bottomAnchor, constant: 8),
            detailSubTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 14),
            detailSubTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            
            detailButton.topAnchor.constraint(equalTo: detailSubTitle.bottomAnchor, constant: 16),
            detailButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
