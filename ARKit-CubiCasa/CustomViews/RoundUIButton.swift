//
//  RoundedImageView.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/3/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit

class RoundUIButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        // Round it
        self.clipsToBounds = true
        self.layer.cornerRadius = self.layer.frame.size.width/2;
        
        // Coloring
        self.backgroundColor = .white
        self.tintColor = .black
        
        // Adjust icon
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
        
        // Inset for icon
        self.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        
        addAnimation()
    }
    
    private func addAnimation() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.98
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = .infinity
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
}
