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
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var medicineSubTitle: UILabel = {
        let label = UILabel()
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

}
