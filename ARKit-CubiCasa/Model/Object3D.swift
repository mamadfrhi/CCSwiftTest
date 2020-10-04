//
//  Object3D.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/3/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import Foundation


enum Object3D {
    case wateringCan
}

extension Object3D {
    var networkURL: URL? {
        switch self {
        case .wateringCan:
            return URL(string: "https://github.com/CubiCasa/CCSwiftTest/raw/master/wateringcan.usdz")
        }
    }
}
