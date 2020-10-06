//
//  ARGlobal.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/5/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import Foundation

enum ARControllerState: Equatable {
    case initial
    case fetchModel
    case objectIsReady
    case canCaptureSnapshot
    case error
}

enum ARSessionState {
    case goodState
    case badState
}

