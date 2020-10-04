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
    init(snapShots: [SnapShot]) {
        self.snapShots = snapShots
        self.snapShotDrawer = SnapShotDrawingOnController()
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .black
        snapShotDrawer.snapShotTapDelegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //---------------------
    // MARK: LifeCycle
    //---------------------
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.clearSnapShots(from: self.view)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.drawAllSnapShots(snapShots: self.snapShots, on: self.view)
    }
    
    //---------------------
    // MARK: Variables
    //---------------------
    private var snapShots: [SnapShot]
    // Dependency
    private var snapShotDrawer: SnapShotDrawingOnController
    
}

extension MapController: SnapShotsDrawing, SnapShotTapDelegate {
    func didTap(snapShot atIndex: Int) {
        print("I'm in Controller named MapController\n snap shot at index \(atIndex) clicked!")
        print("Go to see iamge!")
    }
    
    func drawAllSnapShots(snapShots: [SnapShot], on view: UIView) {
        snapShotDrawer.drawAllSnapShots(snapShots: snapShots, on: view)
    }
    
    func clearSnapShots(from view: UIView) {
        snapShotDrawer.clearSnapShots(from: view)
    }
}









