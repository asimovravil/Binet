//
//  MedicineCell.swift
//  Binet
//
//  Created by Ravil on 11.01.2024.
//

import UIKit

final class MedicineCell: UICollectionViewCell {
    
    static let reuseID = String(describing: MedicineCell.self)
    
    // MARK: - UI
    
    private lazy var medicineCard: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .white
        uiView.layer.cornerRadius = 8
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOpacity = 0.15
        uiView.layer.shadowOffset = CGSize(width: 0, height: 4)
        uiView.layer.shadowRadius = 4
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private lazy var medicineImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imageCell")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var medicineTitle: UILabel = {
        let label = UILabel()
        label.text = "Болезни зерновых культур"
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var medicineSubTitle: UILabel = {
        let label = UILabel()
        label.text = "Среди болезней зерновых культур в настоящее время наиболь­ шую опасность представляют ..."
        label.textAlignment = .left
        label.textColor = UIColor(named: "grayCustom")
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        medicineCard.layer.cornerRadius = 8
        medicineImage.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [medicineCard, medicineImage, medicineTitle, medicineSubTitle].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            medicineCard.topAnchor.constraint(equalTo: contentView.topAnchor),
            medicineCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            medicineCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            medicineCard.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            medicineImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            medicineImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            medicineImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            medicineImage.heightAnchor.constraint(equalToConstant: 82),
            
            medicineTitle.topAnchor.constraint(equalTo: medicineImage.bottomAnchor, constant: 12),
            medicineTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            medicineTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            medicineSubTitle.topAnchor.constraint(equalTo: medicineTitle.bottomAnchor, constant: 6),
            medicineSubTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            medicineSubTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ])
    }
    
    func configure(with drug: Drug) {
        medicineTitle.text = drug.name
        medicineSubTitle.text = drug.description

        if let imageUrl = URL(string: "http://shans.d2.i-partner.ru/\(drug.image)") {
            medicineImage(from: imageUrl)
        } else {
            medicineImage.image = UIImage(named: "imageCell")
        }
    }
    
    private func medicineImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Invalid image data or response")
                return
            }
            
            guard let image = UIImage(data: data) else {
                print("Invalid image data")
                return
            }
            
            DispatchQueue.main.async {
                self?.medicineImage.image = image
            }
        }.resume()
    }
}
