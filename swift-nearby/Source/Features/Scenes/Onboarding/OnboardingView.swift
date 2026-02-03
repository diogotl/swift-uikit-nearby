//
//  OnboardingView.swift
//  swift-nearby
//
//  Created by Diogo on 03/02/2026.
//

import Foundation
import UIKit

class OnboardingView: UIView {
    
    weak var delegate: OnboardingViewDelegate?
    
    let brandIconImageView: UIImageView = {
        let img = UIImageView(
            image: UIImage(named: "mark")
        )
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome to Nearby"
        label.font = Typography.titleXL
        label.textColor = .label
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Discover local events and people around you."
        label.font = Typography.textMD
        label.textColor = .label
        return label
    }()
    
    let howItWorksLabel: UILabel = {
        let label = UILabel()
        label.text = "How it works?"
        label.font = Typography.textSM
        return label
    }()
    
    
    let getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Começar", for: .normal)
        button.setTitleColor(Colors.gray200,for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.backgroundColor = Colors.greenDark
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleGetStartedButtonTap), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func handleGetStartedButtonTap(){
        delegate?.didTapOnboardingButton()
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupUI(){
        
        addSubview(brandIconImageView)
        addSubview(welcomeLabel)
        addSubview(descriptionLabel)
        addSubview(getStartedButton)
        setupConstraints()
        
        var previousView: UIView? = nil
        
        for item in features {
            let featureView = FeatureItemView(
                iconName: item.icon, title: item.title, description: item.description
            )
            featureView.translatesAutoresizingMaskIntoConstraints = false
            //featureView.backgroundColor = .orange
            
            self.addSubview(featureView)
            
            NSLayoutConstraint.activate([
                featureView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                featureView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                featureView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80)
            ])
            
            if let previous = previousView {
                featureView.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 16).isActive = true
            } else {
                featureView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
            }
            
            previousView = featureView
        }
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            brandIconImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 48),
            brandIconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            welcomeLabel.topAnchor.constraint(equalTo: self.brandIconImageView.bottomAnchor, constant: 8),
            welcomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            descriptionLabel.topAnchor.constraint(equalTo: self.welcomeLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            getStartedButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            getStartedButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            getStartedButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            getStartedButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
