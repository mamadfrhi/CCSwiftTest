//
//  MainControllerView.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/3/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit
import RealityKit
import SnapKit

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
        self.addSubview(arView)
        arView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        self.addSubview(dropObjectButton)
        dropObjectButton.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp_bottomMargin).offset(-20)
        }
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
        
        // Make Border
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        
        
        return imageView
    }()
    
    
}
