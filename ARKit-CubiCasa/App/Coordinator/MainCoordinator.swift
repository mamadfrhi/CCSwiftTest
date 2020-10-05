//
//  MainCoordinator.swift
//  iOS-Challenge
//
//  Created by iMamad on 6/3/20.
//  Copyright © 2020 Farshad Mousalou. All rights reserved.
//

import UIKit
import Photos

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.navigationBar.barTintColor = .systemBlue
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let network = Network()
        let arVC = ARController(coordinator: self, network: network)
        navigationController.pushViewController(arVC, animated: true)
    }
    
    func showSnapShots(map snapShots: [SnapShot]) {
        let mapVC = MapController(snapShots: snapShots, coordinator: self)
        navigationController.pushViewController(mapVC, animated: true)
    }
    
    func showSnapShot(image: UIImage) {
        let imagePresenterVC = ImagePresenterController(image: image)
        // Show modally
        navigationController.present(imagePresenterVC, animated: true)
    }
}


