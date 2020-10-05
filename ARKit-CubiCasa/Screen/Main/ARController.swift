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

enum ARControllerState: Equatable {
    case initial
    case fetchModel
    case objectIsReady
    case canCaptureSnapshot
    case error
}

class ARController: UIViewController {
    
    //---------------------
    // MARK: Init
    //---------------------
    init(coordinator: MainCoordinator, network: NetworkService) {
        self.coordinator = coordinator
        self.network = network
        self.stateManager = StateManager(arUI: self.arControllerUI)
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
        //TODO
        arView.session.delegate = self
        arControllerUI.coachView.session = arView.session
        stateManager.state = .initial
        addGestures()
    }
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
        arControllerUI.downloadButton.isUserInteractionEnabled = true
        arControllerUI.downloadButton.addGestureRecognizer(downloadButtonTapped)
        
        // Add gesture on Drop Button
        let dropButtonTapped = UITapGestureRecognizer(target: self,
                                                      action: #selector(drop3DObject))
        arControllerUI.dropObjectButton.isUserInteractionEnabled = true
        arControllerUI.dropObjectButton.addGestureRecognizer(dropButtonTapped)
        
        // Add gesture on Snapshot Button
        arControllerUI.snapshotTakerButton.addTarget(self,
                                               action: #selector(takeSnapShot),
                                               for: .touchUpInside)
        
        // Add gesture on SnapshotMap Button
        // Navigate
        arControllerUI.showSnapshotsButton.addTarget(self,
                                               action: #selector(goToSnapShotsMap),
                                               for: .touchUpInside)
        
    }
}

// ARSessionDelegate
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
