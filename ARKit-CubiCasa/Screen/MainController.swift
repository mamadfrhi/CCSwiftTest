//
//  ViewController.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/3/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit
import RealityKit

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
    // Observer Design Pattern
    // TODO: Do it with RxSwift OR Move the logic to the another class
    //---------------------
    private enum State {
        case initial
        case objectReady
    }
    
    private var state: State = .initial {
        didSet {
            switch state {
            case .objectReady:
                print("Show the drop button")
            case .initial:
                print("Wait please")
            }
        }
    }
    
    //---------------------
    // MARK: Variables
    //---------------------
    private let mainView = MainView()
    private var objectToAdd: ModelEntity? = nil
    // Dependency
    private let network: NetworkService
    
    
    //---------------------
    // MARK: LifeCycle
    //---------------------
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadObject()
        //        arView.session.delegate = self
    }
    
    //---------------------
    // MARK: Functionalities
    //---------------------
    private func loadObject() {
        network.loadModel(object3D: .wateringCan) {
            [weak self]
            (result) in
            guard let sSelf = self else { return}
            switch result {
            case .success(let downloadedObject):
                print("Model downloaded")
                sSelf.objectToAdd = downloadedObject
                sSelf.state = .objectReady
            case .failure(let error):
                print("Error loading model: \(error.localizedDescription)")
            }
        }
    }
}



