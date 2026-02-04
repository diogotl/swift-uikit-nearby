//
//  PlaceDetailsView.swift
//  swift-nearby
//
//  Created by Diogo on 04/02/2026.
//

import UIKit
import Foundation

class PlaceDetailsView: UIView {
    
    public let placeLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleXL
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        addSubview(placeLabel)
        
        
        NSLayoutConstraint.activate([
            placeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            placeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
