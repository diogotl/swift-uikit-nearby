//
//  PlaceDetailsView.swift
//  swift-nearby
//
//  Created by Diogo on 04/02/2026.
//

import UIKit
import Foundation

final class PlaceDetailsView: UIView {
    
    public let backgroundImg: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let container: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 18
        container.clipsToBounds = true
        return container
    }()
    
    public let placeLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleXL
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    public let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textMD
        label.textColor = Colors.gray500
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let divider : UIView = {
        let view = UIView()
        view.backgroundColor = Colors.gray200
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let availableCuponsStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.backgroundColor = Colors.redLight
        stack.layer.cornerRadius = 12
        stack.layer.masksToBounds = true
        return stack
    }()
    
    private let availableCuponsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.redBase
        imageView.image = UIImage(systemName: "tag.fill")
        return imageView
    }()
    
    public let availableCuponsCount: UILabel = {
        let label = UILabel()
        label.font = Typography.titleLG
        label.textColor = Colors.gray600
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let availableCuponsLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textMD
        label.text = "cupons disponíveis"
        label.textColor = Colors.gray600
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let regulationLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textSM
        label.textColor = Colors.gray500
        label.text = "Regulamento"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        
        let regulationText = """
           • Válido apenas para consumo no local
           • Disponível até 31/12/2024
           """
        
        let attributedText = NSAttributedString(
            string: regulationText,
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: Typography.textSM,
                .foregroundColor: Colors.gray500
            ]
        )
        label.attributedText = attributedText
        return label
    }()
    
    public let rulesLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleMD
        label.textColor = .black
        label.text = "Regulações"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    public let infoLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.titleMD
        label.textColor = .black
        label.text = "Informações"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Phone Stack
    private let phoneStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private let phoneIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.gray600
        imageView.image = UIImage(systemName: "phone.fill")
        return imageView
    }()
    
    public let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textSM
        label.textColor = Colors.gray600
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Address Stack
    private let addressStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private let addressIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.gray600
        imageView.image = UIImage(systemName: "mappin.and.ellipse")
        return imageView
    }()
    
    public let addressLabel: UILabel = {
        let label = UILabel()
        label.font = Typography.textSM
        label.textColor = Colors.gray600
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scanQrCodeButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Ler QR Code"
        config.image = UIImage(systemName: "qrcode.viewfinder")
        config.imagePlacement = .leading
        config.imagePadding = 8
        config.baseBackgroundColor = Colors.greenBase
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        
        let button = UIButton(configuration: config)
        button.titleLabel?.font = Typography.titleMD
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        addSubview(backgroundImg)
        addSubview(container)
        container.addSubview(placeLabel)
        container.addSubview(descriptionLabel)
        container.addSubview(availableCuponsStack)
        container.addSubview(divider)
        container.addSubview(regulationLabel)
        container.addSubview(rulesLabel)
        container.addSubview(infoLabel)
        container.addSubview(phoneStack)
        container.addSubview(addressStack)
        addSubview(scanQrCodeButton)
        
        availableCuponsStack.addArrangedSubview(availableCuponsIcon)
        availableCuponsStack.addArrangedSubview(availableCuponsCount)
        availableCuponsStack.addArrangedSubview(availableCuponsLabel)
        
        phoneStack.addArrangedSubview(phoneIcon)
        phoneStack.addArrangedSubview(phoneLabel)
        
        addressStack.addArrangedSubview(addressIcon)
        addressStack.addArrangedSubview(addressLabel)
        
        NSLayoutConstraint.activate([
            
            backgroundImg.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundImg.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundImg.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundImg.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45),
            
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6, constant: -8),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            placeLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 32),
            placeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            placeLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            placeLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),
            
            descriptionLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 40),
            
            availableCuponsStack.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            availableCuponsStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            availableCuponsStack.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor, constant: -16),
            availableCuponsStack.heightAnchor.constraint(equalToConstant: 36),
            
            divider.topAnchor.constraint(equalTo: availableCuponsStack.bottomAnchor, constant: 16),
            divider.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            divider.heightAnchor.constraint(equalToConstant: 1),
            
            rulesLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            rulesLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            rulesLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            regulationLabel.topAnchor.constraint(equalTo: rulesLabel.bottomAnchor, constant: 16),
            regulationLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            regulationLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            regulationLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            
            infoLabel.topAnchor.constraint(equalTo: regulationLabel.bottomAnchor, constant: 16),
            infoLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            phoneStack.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 16),
            phoneStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            phoneStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            addressStack.topAnchor.constraint(equalTo: phoneStack.bottomAnchor, constant: 12),
            addressStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            addressStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            
            scanQrCodeButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            scanQrCodeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            scanQrCodeButton.heightAnchor.constraint(equalToConstant: 56),
            scanQrCodeButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            availableCuponsIcon.widthAnchor.constraint(equalToConstant: 16),
            availableCuponsIcon.heightAnchor.constraint(equalToConstant: 16),
            
            phoneIcon.widthAnchor.constraint(equalToConstant: 20),
            phoneIcon.heightAnchor.constraint(equalToConstant: 20),
            
            addressIcon.widthAnchor.constraint(equalToConstant: 20),
            addressIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        availableCuponsStack.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        availableCuponsStack.isLayoutMarginsRelativeArrangement = true
        availableCuponsStack.spacing = 4
    }
    
    
}
