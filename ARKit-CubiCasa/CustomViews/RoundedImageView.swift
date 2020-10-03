//
//  RoundedImageView.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/3/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Make Border
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
        
        // Colors
        self.backgroundColor = .white
        
        // Enable interaction
        self.isUserInteractionEnabled = true
    }
}


class BluredUILabel: UILabel {
    let background = UIVisualEffectView()
    override func layoutSubviews() {
        super.layoutSubviews()
        addBLurBaclground()
        self.textColor = .red
    }
    
    private func addBLurBaclground() {
        self.addSubview(background)
        background.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
