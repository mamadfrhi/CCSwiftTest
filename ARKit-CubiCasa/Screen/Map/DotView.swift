//
//  DotView.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/6/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit

class DotView: UIView {
    //--------------------------------------
    // MARK: Init
    //--------------------------------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Adjust
        backgroundColor = UIColor.random()
        layer.cornerRadius = 40/2
        isUserInteractionEnabled = true
        
        self.pulseAnimatoin()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
