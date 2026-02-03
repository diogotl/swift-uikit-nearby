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
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .orange
        return scrollView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(mapView)
        addSubview(scrollView)
        addSubview(containerView)
        containerView.addSubview(tableView)
        setupConstraints()
    }
    
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            
            scrollView.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 32),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 48),
            
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant:-8)
            
        ])
    }
}
