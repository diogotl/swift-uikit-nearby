//
//  SplashViewController.swift
//  swift-nearby
//
//  Created by Diogo on 02/02/2026.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    
    private var contentView: SplashView
    private var coordinator: SplashViewCoordinator
    
    public init(
        contentView: SplashView,
        coordinator: SplashViewCoordinator
    ){
        self.contentView = contentView
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        self.view.addSubview(contentView)
        self.navigationController?.isNavigationBarHidden = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
        
        handleFlow()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        ])
    }
    
    private func handleFlow(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.coordinator.navigateToOnboarding()
        }
    }
}
