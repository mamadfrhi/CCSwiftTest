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
        self.addSubview(snapshotButton)
        snapshotButton.snp.makeConstraints {
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
        
        
        
        // Label
        self.addSubview(statusLabel)
        statusLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview()
            $0.right.equalTo(self.downloadButton.snp.left).offset(-10)
            $0.centerY.equalTo(self.downloadButton.snp.centerY)
        }
    }
    
    
    //----------------
    // MARK: Views
    //----------------
    var arView = ARView(frame: CGRect())
    
    var statusLabel: UILabel = {
        let lbl = BluredUILabel()
        lbl.textAlignment = .center
        lbl.textColor = .darkText
        lbl.numberOfLines = 0
        lbl.text = "iMAMADDDDDDDD"
        return lbl
    }()
    
    // Buttons
     var dropObjectButton: RoundButton = {
        let btn = RoundButton(type: .custom)
        let image = UIImage(systemName: "arkit")
        btn.setImage(image, for: .normal)
        btn.isHidden = true
        return btn
    }()
    
    var downloadButton: RoundButton = {
        let btn = RoundButton(type: .custom)
        let image = UIImage(systemName: "icloud.and.arrow.down")
        btn.setImage(image, for: .normal)
        btn.isHidden = true
        return btn
    }()
    
    var snapshotButton: RoundButton = {
        let btn = RoundButton(type: .custom)
        let image = UIImage(systemName: "camera")
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


