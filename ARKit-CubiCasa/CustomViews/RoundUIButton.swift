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
        adjustIcon()
        colorIt()
        border()
        roundIt()
        addAnimation()
    }
    
    private func adjustIcon() {
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
        
        // Inset for icon
        self.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
    }
    
    private func colorIt() {
        self.backgroundColor = .white
        self.tintColor = .black
    }
    private func border() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    private func roundIt() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.layer.frame.size.width/2;
    }
    
    
    
    private func addAnimation() {
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
