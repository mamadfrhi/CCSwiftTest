//
//  MapView.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/6/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit

class MapView: UIView {
    //--------------------------------------
    // MARK: Init
    //--------------------------------------
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(base)
        base.snp.makeConstraints { (make) in
            make.top.equalTo(snp_topMargin).offset(25)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalTo(snp_bottomMargin).offset(-25)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let base: UIView = {
        let vw = UIView()
        return vw
    }()
}
