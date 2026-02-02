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
            contentView: contentView
        )
        
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController!
    }
}

