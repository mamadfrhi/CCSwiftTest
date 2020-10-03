//
//  Network.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/3/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import Foundation
import RealityKit


protocol NetworkService {
    func loadModel(object3D: Object3D,
                   resultHandler: @escaping (Result<ModelEntity, Error>) -> ())
}
