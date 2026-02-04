//
//  Coordinator.swift
//  swift-nearby
//
//  Created by Diogo on 02/02/2026.
//

import Foundation
import UIKit

class Coordinator {
    private var navigationController: UINavigationController?
    
    public init(){
        
    }
    
    func start() -> UINavigationController {
        let contentView = SplashView()
        let startViewController = SplashViewController(
            contentView: contentView,
            coordinator: self
        )
        
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController!
    }
}

extension Coordinator: SplashViewCoordinator {
    func navigateToOnboarding() {
        let contentView = OnboardingView()
        let onboardingViewController = OnboardingViewController(
            contentView: contentView,
            coordinator: self
        )
        navigationController?.pushViewController(onboardingViewController, animated: true)
    }
}

extension Coordinator: OnboardingViewCoordinator {
    func navigateToHome() {
        let contentView = HomeView()
        let viewModel = HomeViewModel()
        let homeViewController = HomeViewController(
            contentView: contentView,
            viewModel: viewModel,
            coordinator: self
        )
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}

extension Coordinator: HomeViewCoordinator{
    func navigateToPlaceDetails(place: Place) {
        let contentView = PlaceDetailsView()
        
        let homeViewController = PlaceDetailsController(
            contentView: contentView,
            place: place
        )
        
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}
