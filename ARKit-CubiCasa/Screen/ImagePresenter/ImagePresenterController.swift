//
//  ImagePresenterController.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/4/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit

class ImagePresenterController: UIViewController {
    
    private let image: UIImage
    private let imagePresenterView = ImagePresenterView()
    
    //---------------------
    // MARK: Init
    //---------------------
    init(image: UIImage) {
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("Class \(type(of: self)) doesn't have retain cycle.")
    }
    
    //---------------------
    // MARK: LifeCycle
    //---------------------
    override func loadView() {
        self.view = imagePresenterView
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        show(image: image)
    }
}

protocol ImagePresnter {
    func show(image: UIImage)
}

extension ImagePresenterController: ImagePresnter {
    func show(image: UIImage) {
        // TODO:
        // Show with animation
        self.imagePresenterView.imageView.image = image
    }
}
