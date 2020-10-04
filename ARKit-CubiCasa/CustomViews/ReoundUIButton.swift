//
//  RoundedImageView.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/3/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit

class ReoundUIButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        // Round it
        self.clipsToBounds = true
        self.layer.cornerRadius = self.layer.frame.size.width/2;
        
        //Background
        self.backgroundColor = .black
        
        // Adjust icon
        self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.fill
        self.contentVerticalAlignment =  UIControl.ContentVerticalAlignment.fill
        
        self.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        
    }
}
