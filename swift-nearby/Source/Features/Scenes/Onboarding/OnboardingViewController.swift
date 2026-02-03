//
//  OnboardingViewController.swift
//  swift-nearby
//
//  Created by Diogo on 03/02/2026.
//

import Foundation
import UIKit


struct FeatureItem  {
    let icon: String
    let title: String
    let description: String
}

let features: [FeatureItem] = [
    FeatureItem(
        icon: "mappin.circle.fill", title: "Encontre estabelecimentos", description: "Veja locais perto de você que são parceiros Nearby"
    ),
    FeatureItem(
        icon: "qrcode", title: "Ative o cupom com QR Code", description: "Escaneie o código no estabelecimento para usar o benefício",
    ),
    FeatureItem(
        icon: "ticket.fill", title: "Garanta vantagens perto de você", description: "Ative cupons onde estiver, em diferentes tipos de estabelecimento "
    )
]

final class OnboardingViewController: UIViewController {
    
    private var contentView: OnboardingView
    weak var coordinator: OnboardingViewCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    init(
        contentView: OnboardingView,
        coordinator: OnboardingViewCoordinator
    ){
        self.contentView = contentView
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        contentView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        self.view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        ])
    }
}


extension OnboardingViewController: OnboardingViewDelegate {
    func didTapOnboardingButton() {
        coordinator?.navigateToHome()
    }
}
