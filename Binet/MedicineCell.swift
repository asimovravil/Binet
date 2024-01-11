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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
