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
import SnapKit

class ARController: UIViewController {
    
    //---------------------
    // MARK: Init
    //---------------------
    init(coordinator: MainCoordinator, network: NetworkService) {
        self.stateManager = StateManager(arUI: self.arControllerUI)
        self.coordinator = coordinator
        self.network = network
        super.init(nibName: nil, bundle: nil)
        self.features = ARImplementation(arController: self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //---------------------
    // MARK: Variables
    //---------------------
    var snapShots: [SnapShot] = []
    var object: ModelEntity? = nil
    //View
    private let arControllerUI = AR_UI()
    var arView: ARView!
    
    // Dependency
    weak var coordinator: MainCoordinator?
    var stateManager: StateManager
    var network: NetworkService
    var features: ARFeature!
    
    //---------------------
    // MARK: LifeCycle
    //---------------------
    override func loadView() {
        self.view = arControllerUI
        self.arView = arControllerUI.arView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "AR View"
        addGestures()
        arView.session.delegate = self
        arControllerUI.coachView.session = arView.session
        stateManager.state = .initial
    }
    // Handle UINavigationBar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //---------------------
    // MARK: Functions
    //---------------------
    private func addGestures() {
        // Add gesture on drop Download Button
        let downloadButtonTapped = UITapGestureRecognizer(target: self,
                                                          action: #selector(downloadObject))
        arControllerUI.downloadButton.addGestureRecognizer(downloadButtonTapped)
        
        // Add gesture on Drop Button
        let dropButtonTapped = UITapGestureRecognizer(target: self,
                                                      action: #selector(drop3DObject))
        arControllerUI.dropObjectButton.addGestureRecognizer(dropButtonTapped)
        
        // Add gesture on Snapshot Button
        arControllerUI.cameraButton.addTarget(self,
                                               action: #selector(takeSnapShot),
                                               for: .touchUpInside)
        
        // Add gesture on SnapshotMap Button
        // Navigate
        arControllerUI.showSnapShotsMapButton.addTarget(self,
                                               action: #selector(goToSnapShotsMap),
                                               for: .touchUpInside)
        
    }
}

//---------------------
// MARK: Features
//---------------------
extension ARController: ARFeature {
    @objc
    func downloadObject() {
        self.features.downloadObject()
    }
    
    @objc
    func drop3DObject() {
        self.features.drop3DObject()
    }
    
    @objc
    func takeSnapShot() {
        self.features.takeSnapShot()
    }
    
    @objc
    func goToSnapShotsMap() {
        guard snapShots.count > 0 else {
            self.arControllerUI.statusLabel.text = "Please capture snapshot."
            return
        }
        coordinator?.showSnapShots(map: snapShots)
    }
}

// ARSessionDelegate
// Use to handle views
extension ARController: ARSessionDelegate {
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        guard let frame = session.currentFrame else { return }
        let state = frame.camera.trackingState
        
        // normal state = Good State
        // others = Bad State
        switch state {
        // Good state
        case .normal:
            stateManager.manageViewWith(sessionState: .goodState)
        default:
            // Bad state
            stateManager.manageViewWith(sessionState: .badState)
        }
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        if stateManager.state == .objectIsReady {
            stateManager.state = .canCaptureSnapshot
        }
    }
}


