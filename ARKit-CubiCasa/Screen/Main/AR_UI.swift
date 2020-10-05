//
//  MainControllerView.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/3/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit
import RealityKit
import ARKit
import SnapKit

// I set AR_UI, because ARView is reserved by the OS
class AR_UI: UIView {
    
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
        // ARView
        self.addSubview(arView)
        arView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        // Coaching View
        self.addSubview(coachView)
        coachView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        
        // Add Buttons
        // Download Button
        self.addSubview(cameraButton)
        cameraButton.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp_bottomMargin).offset(-20)
        }
        
        // Drop Button
        self.addSubview(dropObjectButton)
        dropObjectButton.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp_bottomMargin).offset(-20)
        }
        // Download Button
        self.addSubview(downloadButton)
        downloadButton.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(snp_bottomMargin).offset(-20)
        }
        
        // Show SnapShots Button
        self.addSubview(showSnapShotsMapButton)
        showSnapShotsMapButton.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.left.equalTo(self.cameraButton.snp.right).offset(10)
            $0.centerY.equalTo(self.cameraButton.snp.centerY)
            
        }
        
        
        
        // Status Label
        self.addSubview(statusLabel)
        statusLabel.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.left.equalToSuperview().offset(8)
            $0.bottom.equalTo(snp_bottomMargin).offset(-20)
        }
    }
    
    
    //----------------
    // MARK: Views
    //----------------
    var arView = ARView(frame: CGRect())
    
    var statusLabel: BluredUILabel = {
        let lbl = BluredUILabel()
        return lbl
    }()
    
    // Buttons
    var downloadButton: RoundUIButton = {
        let btn = RoundUIButton(type: .custom)
        let image = UIImage(systemName: "icloud.and.arrow.down")
        btn.setImage(image, for: .normal)
        return btn
    }()
    
    var dropObjectButton: RoundUIButton = {
        let btn = RoundUIButton(type: .custom)
        let image = UIImage(systemName: "arkit")
        btn.setImage(image, for: .normal)
        btn.isHidden = true
        return btn
    }()
    
    
    var cameraButton: RoundUIButton = {
        let btn = RoundUIButton(type: .custom)
        let image = UIImage(systemName: "camera")
        btn.setImage(image, for: .normal)
        btn.isHidden = true
        return btn
    }()
    
    var showSnapShotsMapButton: RoundUIButton = {
        let btn = RoundUIButton(type: .custom)
        let image = UIImage(systemName: "mappin.and.ellipse")
        btn.setImage(image,
                     for: .normal)
        btn.isHidden = true
        return btn
    }()
    
    
    
    
    let coachView : ARCoachingOverlayView = {
        let coachingView = ARCoachingOverlayView()
        coachingView.isHidden = true
        coachingView.activatesAutomatically = true
        coachingView.goal = .horizontalPlane
        return coachingView
    }()
    
}


