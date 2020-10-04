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

class ARController: UIViewController {
    
    //---------------------
    // MARK: Init
    //---------------------
    init(network: NetworkService) {
        self.network = network
        super.init(nibName: nil, bundle: nil)
        self.features = ARControllerImplementation(arController: self)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //---------------------
    // MARK: Variables
    //---------------------
    var snapshots: [SnapShot] = []
    var object: ModelEntity? = nil
    //View
    private let arViewUI = ARControllerUI()
    var arView: ARView!
    
    // Dependency
    var network: NetworkService
    var features: ARControllerFeatures!
    
    //---------------------
    // MARK: State Management
    //---------------------
    var state: ARControllerState = .initial {
        didSet {
            switch state {
            case .initial:
                // Show coach view
                self.arViewUI.coachView.isHidden = false
                arViewUI.statusLabel.text = "Press to download mode!l"
                print("I'm in initial state.")
            case .fetchModel:
                arViewUI.downloadButton.isHidden = true
                arViewUI.statusLabel.text = "I'm downloading model..."
                print("Is downloading...")
            case .objectIsReady:
                // Show DropButton
                arViewUI.downloadButton.isHidden = true
                arViewUI.dropObjectButton.isHidden = false
                arViewUI.statusLabel.text = "Press to drop object."
                print("Show the drop button")
            case .canCaptureSnapshot:
                arViewUI.dropObjectButton.isHidden = true
                arViewUI.snapshotTakerButton.isHidden = false
                arViewUI.statusLabel.text = "Press to capture snapshot."
                print("now you can get snapshot")
                
            case .canShowSnapshots:
                arViewUI.statusLabel.text = "Press to drop the model"
                arViewUI.showSnapshotsButton.isHidden = false
                print("Go to see on Map")
            case .error:
                self.arViewUI.statusLabel.text = "An error occured!"
                
            }
        }
    }
    
    //---------------------
    // MARK: LifeCycle
    //---------------------
    override func loadView() {
        self.view = arViewUI
        self.arView = arViewUI.arView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        arView.session.delegate = self
        arViewUI.coachView.session = arView.session
        self.state = .initial
        addGestures()
    }
    
    //---------------------
    // MARK: Functions
    //---------------------
    private func addGestures() {
        // Add gesture on drop Download Button
        let downloadButtonTapped = UITapGestureRecognizer(target: self,
                                                          action: #selector(downloadObject))
        arViewUI.downloadButton.isUserInteractionEnabled = true
        arViewUI.downloadButton.addGestureRecognizer(downloadButtonTapped)
        
        // Add gesture on Drop Button
        let dropButtonTapped = UITapGestureRecognizer(target: self,
                                                      action: #selector(drop3DObject))
        arViewUI.dropObjectButton.isUserInteractionEnabled = true
        arViewUI.dropObjectButton.addGestureRecognizer(dropButtonTapped)
        
        // Add gesture on Snapshot Button
        arViewUI.snapshotTakerButton.addTarget(self,
                                               action: #selector(takeSnapShot),
                                               for: .touchUpInside)
        
        // Add gesture on SnapshotMap Button
        // Navigate
        arViewUI.showSnapshotsButton.addTarget(self,
                                               action: #selector(goToSnapshotsMap),
                                               for: .touchUpInside)
        
    }
}

// AR Delegate
extension ARController: ARSessionDelegate {
}

// Features
extension ARController: ARControllerFeatures {
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
    func goToSnapshotsMap() {
        print("I'm going to see map!")
    }
}
