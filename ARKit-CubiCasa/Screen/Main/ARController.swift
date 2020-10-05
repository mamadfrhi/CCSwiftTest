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

enum ARControllerState {
    case initial
    case fetchModel
    case objectIsReady
    case canCaptureSnapshot
    case canShowSnapshots
    case error
}

class ARController: UIViewController, ARSessionDelegate {
    
    //---------------------
    // MARK: Init
    //---------------------
    init(coordinator: MainCoordinator, network: NetworkService) {
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
    var network: NetworkService
    weak var coordinator: MainCoordinator?
    var features: ARFeature!
    
    //---------------------
    // MARK: State Management
    //---------------------
    var state: ARControllerState = .initial {
        didSet {
            switch state {
            case .initial:
                // Show coach view
                self.arControllerUI.coachView.isHidden = false
                //TODO
//                self.arControllerUI.showSnapshotsButton.isHidden = false
                arControllerUI.statusLabel.text = "Press to download model!"
                print("I'm in initial state.")
            case .fetchModel:
                arControllerUI.downloadButton.isHidden = true
                arControllerUI.statusLabel.text = "I'm downloading model..."
                print("Is downloading...")
            case .objectIsReady:
                // Show DropButton
                arControllerUI.downloadButton.isHidden = true
                arControllerUI.dropObjectButton.isHidden = false
                arControllerUI.statusLabel.text = "Press to drop object."
                print("Show the drop button")
            case .canCaptureSnapshot:
                arControllerUI.dropObjectButton.isHidden = true
                arControllerUI.snapshotTakerButton.isHidden = false
                arControllerUI.statusLabel.text = "Press to capture snapshot."
                print("now you can get snapshot")
            case .canShowSnapshots:
                arControllerUI.showSnapshotsButton.isHidden = false
                arControllerUI.statusLabel.text = "Now, you can watch snapshots map"
                print("Go to see on Map")
            case .error:
                self.arControllerUI.statusLabel.text = "An error occured!"
                
            }
        }
    }
    
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
//        arView.session.delegate = self
//        arControllerUI.coachView.session = arView.session
        self.state = .initial
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
        snapShots.append(SnapShot(image: UIImage(),
                                  cameraTransform: Transform()))
        guard snapShots.count > 0 else {
            self.arControllerUI.statusLabel.text = "Please capture snapshot."
            return
        }
        coordinator?.showSnapShots(map: snapShots)
    }
}
