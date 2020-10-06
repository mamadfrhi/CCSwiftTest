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
        pulseAnimatoin()
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
}
