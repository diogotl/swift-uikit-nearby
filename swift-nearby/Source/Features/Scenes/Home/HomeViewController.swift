//
//  HomeViewController.swift
//  swift-nearby
//
//  Created by Diogo on 03/02/2026.
//

import Foundation
import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    let contentView: HomeView
    let viewModel: HomeViewModel
    //weak var coordinator: HomeViewCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    init(
        contentView: HomeView,
        viewModel: HomeViewModel
        // coordinator: HomeViewCoordinator
    ){
        self.contentView = contentView
        self.viewModel = viewModel
        //self.coordinator = coordinator
        viewModel.fetchPlaces(for: "146b1a88-b3d3-4232-8b8f-c1f006f1e86d", userLocation: CLLocationCoordinate2D(
            latitude: 37.7749,
            longitude: -122.4194
        ))
        super.init(nibName: nil, bundle: nil)
        self.setupPlacesTableView()
    }
    
    private func setupPlacesTableView(){
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        
        viewModel.didUpdatePlaces = { [weak self] in
            self?.contentView.tableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath)
                as? PlaceTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: self.viewModel.places[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        tableView.deselectRow(at: indexPath, animated: true)
    //        let details = DetailsViewController()
    //        details.place = places[indexPath.row]
    //        navigationController?.pushViewController(details, animated: true)
    //    }
}
