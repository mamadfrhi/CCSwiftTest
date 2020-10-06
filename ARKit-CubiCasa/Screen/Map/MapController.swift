//
//  MapController.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/4/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit

class MapController: UIViewController {
    //---------------------
    // MARK: Init
    //---------------------
    init(snapShots: [SnapShot], coordinator: MainCoordinator) {
        self.snapShots = snapShots
        self.coordinator = coordinator
        self.snapShotDrawer = SnapShotDrawer()
        super.init(nibName: nil, bundle: nil)
        snapShotDrawer.snapShotTapDelegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("Class \(type(of: self)) doesn't have retain cycle.")
    }
    
    //---------------------
    // MARK: LifeCycle
    //---------------------
    override func loadView() {
        let mapView = MapView()
        self.view = mapView
        self.mapView = mapView.base
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.title = "Snapshots Map"
        self.clearSnapShots(from: self.mapView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.drawAllSnapShots(snapShots: self.snapShots, on: self.mapView)
    }
    
    //---------------------
    // MARK: Variables
    //---------------------
    private var snapShots: [SnapShot]
    var mapView: UIView!
    
    // Dependency
    private var snapShotDrawer: SnapShotDrawer
    weak var coordinator: MainCoordinator?
    
}

extension MapController: SnapShotsDraw, SnapShotTapDelegate {
    func drawAllSnapShots(snapShots: [SnapShot], on view: UIView) {
        snapShotDrawer.drawAllSnapShots(snapShots: snapShots, on: self.mapView)
    }
    
    func clearSnapShots(from view: UIView) {
        snapShotDrawer.clearSnapShots(from: self.mapView)
    }
    
    func didTap(snapShot atIndex: Int) {
        print("Go to see image at index \(atIndex)!")
        let snapShotImage = self.snapShots[atIndex].image
        coordinator?.showSnapShot(image: snapShotImage)
    }
}
