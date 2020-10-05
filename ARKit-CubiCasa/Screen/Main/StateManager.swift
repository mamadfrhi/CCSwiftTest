//
//  StateManager.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/5/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import Foundation

class StateManager {
    weak var arUI: AR_UI?
    init(arUI: AR_UI) {
        self.arUI = arUI
    }
    
    var state: ARControllerState = .initial {
        willSet {
            manageView(with: newValue)
        }
    }
    
    private func manageView(with state: ARControllerState) {
        switch state {
        case .initial:
            // Show coach view
            arUI?.coachView.isHidden = false
            arUI?.statusLabel.text = "Press to download model!"
            print("I'm in initial state.")
        case .fetchModel:
            arUI?.statusLabel.text = "I'm downloading model..."
            
            arUI?.downloadButton.removeFromSuperview()
            print("Is downloading...")
        case .objectIsReady:
            // Show DropButton
            arUI?.downloadButton.isHidden = true
            arUI?.dropObjectButton.isHidden = false
            arUI?.statusLabel.text = "Press to drop object."
            print("Show the drop button")
        case .canCaptureSnapshot:
            // Object dropped
            arUI?.dropObjectButton.removeFromSuperview()
            
            arUI?.snapshotTakerButton.isHidden = false
            arUI?.showSnapshotsButton.isHidden = false
            arUI?.statusLabel.text = "Press to capture snapshot Or see map."
        case .error:
            arUI?.statusLabel.isHidden = false
            arUI?.statusLabel.text = "An error occured!"
            
            arUI?.downloadButton.isHidden = true
            arUI?.dropObjectButton.isHidden = true
            arUI?.showSnapshotsButton.isHidden = true
            arUI?.snapshotTakerButton.isHidden = true
        }
    }
    
    func manageViewWith(sessionState: ARSessionState) {
        if sessionState == .goodState {
            arUI?.statusLabel.isHidden = false
        }

        if sessionState == .goodState && self.state == .objectIsReady{
            arUI?.dropObjectButton.isHidden = false
        }else if sessionState == .badState && state == .initial {
            arUI?.statusLabel.isHidden = false
            arUI?.dropObjectButton.isHidden = true
        }else if sessionState == .badState {
            arUI?.statusLabel.isHidden = true
            arUI?.dropObjectButton.isHidden = true
        }
    }
}

enum ARSessionState {
    case goodState
    case badState
}
