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
        case canCaptureSnapshot
        case error
    }
    private var state: State = .initial {
        didSet {
            switch state {
            case .initial:
                mainView.snapshotButton.isHidden = false
                mainView.downloadButton.isHidden = true
                // Show Layer
                print("I'm in initial state.")
                self.mainView.coachView.isHidden = false
                mainView.statusLabel.text = "Press to download model"
            case .fetchModel:
                print("Is downloading...")
                mainView.downloadButton.isHidden = true
                mainView.statusLabel.text = "I'm downloading model"
            // Label: I'm downloading the object
            case .objectIsReady:
                // Show DropButton
                print("Show the drop button")
                mainView.downloadButton.isHidden = true
                mainView.dropObjectButton.isHidden = false
                mainView.statusLabel.text = "Press to drop the model"
            case .canCaptureSnapshot:
                mainView.dropObjectButton.isHidden = true
                mainView.snapshotButton.isHidden = false
                print("now you can get snapshot")
            case .error:
                self.mainView.statusLabel.text = "An error occured!"
                
            }
        }
    }
    
    //---------------------
    // MARK: Variables
    //---------------------
    //View
    private let mainView = MainView()
    private var arView: ARView!
    
    private var snapshots: [SnapShot] = [] {
        willSet {
            print("My new snapshpt is: \n \(newValue)")
        }
    }
    private var object: ModelEntity? = nil
    // Dependency
    private var network: NetworkService
    
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
//        arView.session.delegate = self
//        mainView.coachView.session = arView.session
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
        mainView.downloadButton.isUserInteractionEnabled = true
        mainView.downloadButton.addGestureRecognizer(downloadButtonTapped)
        
        // Add gesture on Drop Button
        let dropButtonTapped = UITapGestureRecognizer(target: self,
                                                      action: #selector(drop3DObject))
        mainView.dropObjectButton.isUserInteractionEnabled = true
        mainView.dropObjectButton.addGestureRecognizer(dropButtonTapped)
        
        // Add gesture on Snapshot Button
        mainView.snapshotButton.addTarget(self,
                                          action: #selector(takeSnapShot),
                                          for: .touchUpInside)
        
    }
}

// AR Delegate
extension MainController: ARSessionDelegate {
}

// Features
extension MainController: MainViewControllerFeatures {
    @objc
    func downloadObject() {
        self.state = .fetchModel
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
                print("Error when loading model: \(error.localizedDescription)")
            }
        }
    }
    
    @objc
    func drop3DObject() {
        print("Drop model button pressed!")
        guard let myFinalObject = object else {
            state = .error
            return
        }
//        // Place the object
//        //TODO
//        let anchorEntity = AnchorEntity(plane: .horizontal)
//
//        arView.scene.anchors.append(anchorEntity)
//        anchorEntity.addChild(myFinalObject)
//
//        state = .canCaptureSnapshot
        
    }
    
    @objc
    func takeSnapShot() {
        print("Take snapshot button pressed!")
        let cameraTransform = arView.cameraTransform
        arView.snapshot(saveToHDR: false) {
            [weak self]
            (arViewImage) in
            guard let image = arViewImage,
                let sSelf = self else {
                return
            }
            let snapShot = SnapShot(image: image,
                                    cameraTransform: cameraTransform)
            sSelf.snapshots.append(snapShot)
            
        }
    }
}


