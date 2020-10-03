//
//  MainControllerView.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/3/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit
import RealityKit

class MainView: UIView {
    
    //--------------------------------------
    // MARK: Init
    //--------------------------------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //--------------------------------------
    // MARK: Functions
    //--------------------------------------
    private func addViews() {
        // It needs SnapKit
        
    }
    
    
    //----------------
    // MARK: Views
    //----------------
    var arView = ARView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Clean Your Gallery!"
        lbl.textAlignment = .center
        lbl.textColor = .darkText
        lbl.font = UIFont.init(name: "Arial Rounded MT Bold", size: 33)
        lbl.numberOfLines = 0
        return lbl
    }()
    
     var dropObjectButton: UIImageView = {
        let imageName = "DropObjectIcon.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return imageView
    }()
    
    
}
