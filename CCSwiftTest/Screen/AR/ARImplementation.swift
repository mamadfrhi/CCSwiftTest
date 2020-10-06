//
//  ARViewControllerImplementation.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/4/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit
import RealityKit

class ARImplementation: ARFeature {
    weak var arController: ARController!
    init(arController: ARController) {
        self.arController = arController
    }
    
    func downloadObject() {
        arController.stateManager.state = .fetchModel
        arController.network.loadModel(object3D: .wateringCan) {
            [weak self]
            (result) in
            guard let sSelf = self else { return}
            switch result {
            case .success(let downloadedObject):
                print("Model downloaded")
                sSelf.arController.object = downloadedObject
                sSelf.arController.stateManager.state = .objectIsReady
            case .failure(let error):
                print("Error when loading model: \(error.localizedDescription)")
            }
        }
    }
    
    func drop3DObject() {
        print("Drop model button pressed!")
        guard let myFinalObject = arController.object else {
            arController.stateManager.state = .error
            return
        }
        // Place the object
        let anchorEntity = AnchorEntity(plane: .horizontal)

        arController.arView.scene.anchors.append(anchorEntity)
        anchorEntity.addChild(myFinalObject)
    }
    
    func takeSnapShot() {
        print("Take snapshot button pressed!")
        let cameraTransform = arController.arView.cameraTransform
        arController.arView.snapshot(saveToHDR: false) {
            [weak self]
            (arViewImage) in
            guard let image = arViewImage,
                let sSelf = self else { return}
            
            let snapShot = SnapShot(image: image,
                                    cameraTransform: cameraTransform)
            sSelf.arController.snapShots.append(snapShot)
        }
    }
}
