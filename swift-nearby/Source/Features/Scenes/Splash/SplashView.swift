//
//  SplashView.swift
//  swift-nearby
//
//  Created by Diogo on 02/02/2026.
//

import Foundation
import UIKit

class SplashView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    let branding: UIImageView = {
        let img = UIImageView(image: UIImage(named: "branding"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let background: UIImageView = {
        let img = UIImageView(image: UIImage(named: "background"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.backgroundColor = Colors.greenLight
        addSubview(background)
        addSubview(branding)
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            branding.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            branding.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            branding.widthAnchor.constraint(equalToConstant: 200),
            background.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
}
