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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        
        // Configurar textos DEPOIS da view estar na hierarquia
        contentView.placeLabel.text = place.name
        contentView.descriptionLabel.text = place.description
        contentView.availableCuponsCount.text = "\(place.coupons)"
        contentView.phoneLabel.text = place.phone
        contentView.addressLabel.text = place.address
        
        loadImage(from: place.cover)
        
        //contentView.setNeedsLayout()
        //contentView.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func loadImage(from urlString: String) {
        contentView.backgroundImg.backgroundColor = Colors.gray300
        
        guard let url = URL(string: urlString) else {
            print("URL inválida: \(urlString)")
            return
        }
        
        // Baixar imagem em background
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Erro ao carregar imagem: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Erro ao converter dados em imagem")
                return
            }
            
            // Atualizar UI na main thread
            DispatchQueue.main.async {
                self.contentView.backgroundImg.image = image
                self.contentView.backgroundImg.backgroundColor = .clear
            }
        }.resume()
    }
    
    private func setupUI() {
        view.backgroundColor = .black
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
