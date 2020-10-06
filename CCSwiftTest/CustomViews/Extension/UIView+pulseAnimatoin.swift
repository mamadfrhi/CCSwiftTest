//
//  UIView+pulseAnimatoin.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/6/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit

extension UIView {
    func pulseAnimatoin() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.97
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
