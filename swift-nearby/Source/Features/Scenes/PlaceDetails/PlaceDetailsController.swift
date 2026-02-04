//
//  PlaceDetailsController.swift
//  swift-nearby
//
//  Created by Diogo on 04/02/2026.
//

import UIKit
import Foundation

final class PlaceDetailsController: UIViewController {
    
    let contentView: PlaceDetailsView
    
    let place: Place
    
    init(
        contentView: PlaceDetailsView,
        place: Place
    ){
        self.contentView = contentView
        self.place = place
        super.init(nibName: nil, bundle: nil)
        
        print(place)
        self.contentView.placeLabel.text = place.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Detalhes"
        
        let leftButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(leftButtonTapped)
        )
        navigationItem.leftBarButtonItem = leftButton
        
        let rightButton = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(rightButtonTapped)
        )
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc
    private func leftButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func rightButtonTapped() {
        print("Right button tapped for place: \(place.name)")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
