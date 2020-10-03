//
//  ViewController.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/3/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class MainController: UIViewController {
    
    //---------------------
    // MARK: Init
    //---------------------
    init(network: NetworkService) {
        self.network = network
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //---------------------
    // MARK: State Management
    //---------------------
    private enum State {
        case initial
        case fetchModel
        case objectIsReady
    }
    private var state: State = .initial {
        didSet {
            switch state {
            case .initial:
                // Show Layer
                print("I'm in initial state.")
                self.mainView.coachView.isHidden = false
            case .fetchModel:
                print("Is downloading...")
                // Label: I'm downloading the object
            case .objectIsReady:
                // Show DropButton
                print("Show the drop button")
                // Hide Label
                // Show Drop Button
                
            }
        }
    }
    
    //---------------------
    // MARK: Variables
    //---------------------
    //View
    private let mainView = MainView()
    private var arView: ARView!
    
    private var object: ModelEntity? = nil
    // Dependency
    private let network: NetworkService
    
    
    //---------------------
    // MARK: LifeCycle
    //---------------------
    override func loadView() {
        self.view = mainView
        self.arView = mainView.arView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        arView.session.delegate = self
        mainView.coachView.session = arView.session
        addGestures()
    }
    
    //---------------------
    // MARK: Functions
    //---------------------
    private func addGestures() {
    // Add gesture on main btn
    let dropButtonTapped = UITapGestureRecognizer(target: self,
                                              action: #selector(drop3DObject))
    mainView.dropObjectButton.addGestureRecognizer(dropButtonTapped)
        
    }
}

// AR Delegate
extension MainController: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        
    }
}

// Features
extension MainController: MainViewControllerFeatures {
    func fetchModel() {
        network.loadModel(object3D: .wateringCan) {
            [weak self]
            (result) in
            guard let sSelf = self else { return}
            switch result {
            case .success(let downloadedObject):
                print("Model downloaded")
                sSelf.object = downloadedObject
                sSelf.state = .objectIsReady
            case .failure(let error):
                print("Error loading model: \(error.localizedDescription)")
            }
        }
    }
    
    @objc
    func drop3DObject() {
        print("Drop model")
    }
}


