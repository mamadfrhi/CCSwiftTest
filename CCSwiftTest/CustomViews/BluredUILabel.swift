//
//  BluredLabel.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/4/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit

class BluredUILabel: UIVisualEffectView {
    
    //----------------
    // MARK: Variables
    //----------------
    var text: String! {
        willSet {
            changeText(with: newValue)
        }
    }
    private var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkText
        label.numberOfLines = 0
        label.text = "It's empty label"
        return label
    }()
    
    //----------------
    // MARK: Init
    //----------------
    override init(effect: UIVisualEffect?) {
        super.init(effect: UIBlurEffect(style: .light))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //----------------
    // MARK: LifeCycle
    //----------------
    override func layoutSubviews() {
        super.layoutSubviews()
        // Round it
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        addBlurBackground()
    }
    
    private func addBlurBackground() {
        self.contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //----------------
    // MARK: Function
    //----------------
    private func changeText(with newString: String) {
        UIView.transition(with: label,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: {
                            [weak self] in
                            self?.label.text = newString })
    }
}

