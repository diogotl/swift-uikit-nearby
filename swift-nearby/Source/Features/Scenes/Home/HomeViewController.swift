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
    weak var coordinator: HomeViewCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    init(
        contentView: HomeView,
        viewModel: HomeViewModel,
        coordinator: HomeViewCoordinator
    ){
        self.contentView = contentView
        self.viewModel = viewModel
        self.coordinator = coordinator

        super.init(nibName: nil, bundle: nil)

        contentView.delegate = self
        viewModel.fetchPlaces(for: "146b1a88-b3d3-4232-8b8f-c1f006f1e86d", userLocation: CLLocationCoordinate2D(
            latitude: 37.7749,
            longitude: -122.4194
        ))

        self.setupPlacesTableView()
        self.setupCategoriesScrollView()

        viewModel.fetchCategories { [weak self] _ in
        }
    }

    private func setupCategoriesScrollView(){
        contentView.scrollView.delegate = self

        viewModel.didUpdateCategories = { [weak self] in
            guard let self = self else { return }
            self.contentView.configureCategories(self.viewModel.categories)

            if let firstCategory = self.viewModel.categories.first {
                self.viewModel.selectCategory(firstCategory.id)
            }
        }

        viewModel.didSelectCategory = { [weak self] categoryId in
            guard let self = self else { return }
            self.contentView.updateSelectedCategory(categoryId)

            self.viewModel.fetchPlaces(
                for: categoryId,
                userLocation: CLLocationCoordinate2D(
                    latitude: self.viewModel.userLatitude,
                    longitude: self.viewModel.userLongitude
                )
            )
        }
    }

    private func setupPlacesTableView(){
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self

        viewModel.didUpdatePlaces = { [weak self] in
            guard let self = self else { return }
            self.contentView.tableView.reloadData()
            self.contentView.showPlacesOnMap(self.viewModel.places)
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.navigateToPlaceDetails(place: viewModel.places[indexPath.row])
    }
}

extension HomeViewController: HomeViewDelegate {
    func didSelectCategory(_ categoryId: String) {
        viewModel.selectCategory(categoryId)
    }
}
