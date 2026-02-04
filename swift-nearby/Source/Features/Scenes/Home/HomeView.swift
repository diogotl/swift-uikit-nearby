//
//  HomeView.swift
//  swift-nearby
//
//  Created by Diogo on 03/02/2026.
//

import Foundation
import UIKit
import MapKit

class HomeView: UIView{

    weak var delegate: HomeViewDelegate?
    private var categoryButtons: [String: UIButton] = [:]
    private var containerTopConstraint: NSLayoutConstraint!

    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    let categoriesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: -2)
        view.layer.shadowRadius = 8
        return view
    }()
    
    let handleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray300
        view.layer.cornerRadius = 2.5
        return view
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.backgroundColor = .black
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupGestures()
    }
    
    private func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        handleView.addGestureRecognizer(panGesture)
        
        // Também adiciona gesture no container para poder arrastar de qualquer lugar
        let containerPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        containerPanGesture.delegate = self
        containerView.addGestureRecognizer(containerPanGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        addSubview(mapView)
        addSubview(scrollView)
        scrollView.addSubview(categoriesStackView)
        addSubview(containerView)
        containerView.addSubview(handleView)
        containerView.addSubview(tableView)
        setupConstraints()
    }


    private func setupConstraints(){
        containerTopConstraint = containerView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -16)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),

            scrollView.topAnchor.constraint(equalTo:self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 48),

            categoriesStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            categoriesStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            categoriesStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            categoriesStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerTopConstraint,
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            handleView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            handleView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            handleView.widthAnchor.constraint(equalToConstant: 40),
            handleView.heightAnchor.constraint(equalToConstant: 5),

            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            tableView.topAnchor.constraint(equalTo: handleView.bottomAnchor, constant: 16),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant:-8)

        ])
    }

    func configureCategories(_ categories: [Category]) {
        categoriesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        categoryButtons.removeAll()

        for category in categories {
            let button = UIButton(type: .system)
            button.setTitle(category.name, for: .normal)
            button.backgroundColor = Colors.gray100
            button.setTitleColor(Colors.gray600, for: .normal)
            button.layer.cornerRadius = 12
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = category.id.hashValue

            // Store button reference
            categoryButtons[category.id] = button

            // Add tap action
            button.addAction(UIAction { [weak self] _ in
                self?.delegate?.didSelectCategory(category.id)
            }, for: .touchUpInside)

            categoriesStackView.addArrangedSubview(button)
        }
    }

    func updateSelectedCategory(_ categoryId: String) {
        // Reset all buttons to default state
        categoryButtons.values.forEach { button in
            button.backgroundColor = Colors.gray100
            button.setTitleColor(Colors.gray600, for: .normal)
        }

        // Highlight selected button
        if let selectedButton = categoryButtons[categoryId] {
            selectedButton.backgroundColor = Colors.greenBase
            selectedButton.setTitleColor(.white, for: .normal)
        }
    }
    
    // Mostra os lugares no mapa - SIMPLES!
    func showPlacesOnMap(_ places: [Place]) {
        // Remove pins antigos
        mapView.removeAnnotations(mapView.annotations)
        
        // Adiciona um pin para cada lugar
        for place in places {
            let pin = MKPointAnnotation()
            pin.coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
            pin.title = place.name
            pin.subtitle = place.address
            mapView.addAnnotation(pin)
        }
        
        // Ajusta o zoom para mostrar todos os pins
        if !places.isEmpty {
            let coordinates = places.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }
            let region = MKCoordinateRegion(
                center: coordinates.first!,
                latitudinalMeters: 5000,
                longitudinalMeters: 5000
            )
            mapView.setRegion(region, animated: true)
        }
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let velocity = gesture.velocity(in: self)
        
        switch gesture.state {
        case .changed:
            let newConstant = containerTopConstraint.constant + translation.y
            if newConstant <= 0 && newConstant >= frame.height * 0.5 {
                containerTopConstraint.constant = newConstant
                gesture.setTranslation(.zero, in: self)
            }
        case .ended:
            let halfScreenHeight = -frame.height * 0.25
            let finalPosition: CGFloat
            
            if velocity.y > 0 {
                finalPosition = -16
            } else {
                finalPosition = halfScreenHeight
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.containerTopConstraint.constant = finalPosition
                self.layoutIfNeeded()
            })
            
        default:
            break
        }
    }
}

extension HomeView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGesture = gestureRecognizer as? UIPanGestureRecognizer {
            let velocity = panGesture.velocity(in: self)
            return abs(velocity.y) > abs(velocity.x)
        }
        return true
    }
}
