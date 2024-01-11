//
//  DragDetailViewController.swift
//  Binet
//
//  Created by Ravil on 11.01.2024.
//

import UIKit
import SafariServices

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
        button.addTarget(self, action: #selector(openWebsite), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        setupNavigationBar()
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
            detailImage.widthAnchor.constraint(equalToConstant: 117),
            
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
    
    // MARK: - Setup Navigation Bar
    
    private func setupNavigationBar() {
        let leftImage = UIImage(named: "left.pdf")
        let leftBarButtonItem = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(leftBarButtonTapped))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(named: "greenCustom")
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @objc func leftBarButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Configure With Drug Detail
    
    func configureWithDrug(_ drug: Drug) {
        detailTitle.text = drug.name
        detailSubTitle.text = drug.description

        if let logoImageUrl = URL(string: "http://shans.d2.i-partner.ru/\(drug.categories.icon)") {
            loadImage(from: logoImageUrl, into: detailLogo)
        } else {
            detailLogo.image = UIImage(named: "logo")
        }

        if let detailImageUrl = URL(string: "http://shans.d2.i-partner.ru/\(drug.image)") {
            loadImage(from: detailImageUrl, into: detailImage)
        } else {
            detailLogo.image = UIImage(named: "detailImage")
        }
    }

    private func loadImage(from url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let _ = self else { return }

            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                return
            }

            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }
    
    // MARK: - Action
    
    @objc func openWebsite() {
        if let url = URL(string: "https://www.mic.by/spravochnaya-informatsiyap/klassifikatsiya-lekarstvennykh-sredstv/") {
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
        }
    }
}
