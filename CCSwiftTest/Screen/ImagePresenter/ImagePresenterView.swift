//
//  ImagePresenterView.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/4/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit
import SnapKit

class ImagePresenterView: UIView {
    
    //--------------------------------------
    // MARK: Init
    //--------------------------------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let imgVw = UIImageView()
        return imgVw
    }()
}
