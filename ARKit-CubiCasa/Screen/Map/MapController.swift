//
//  MapController.swift
//  ARKit-CubiCasa
//
//  Created by iMamad on 10/4/20.
//  Copyright © 2020 Kabok. All rights reserved.
//

import UIKit

class MapController: UIViewController {
    //---------------------
    // MARK: Init
    //---------------------
    init(snapShots: [SnapShot]) {
        self.snapShots = snapShots
        self.snapShotDrawer = SnapShotDrawingOnController()
        super.init(nibName: nil, bundle: nil)
        snapShotDrawer.snapShotTapDelegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //---------------------
    // MARK: LifeCycle
    //---------------------
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.clearSnapShots(from: self.view)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.drawAllSnapShots(snapShots: self.snapShots, on: self.view)
    }
    
    //---------------------
    // MARK: Variables
    //---------------------
    private var snapShots: [SnapShot]
    // Dependency
    private var snapShotDrawer: SnapShotDrawingOnController
    
}

extension MapController: SnapShotsDrawing, SnapShotTapDelegate {
    func didTap(snapShot atIndex: Int) {
        print("I'm in Controller named MapController\n snap shot at index \(atIndex) clicked!")
        print("Go to see iamge!")
    }
    
    func drawAllSnapShots(snapShots: [SnapShot], on view: UIView) {
        snapShotDrawer.drawAllSnapShots(snapShots: snapShots, on: view)
    }
    
    func clearSnapShots(from view: UIView) {
        snapShotDrawer.clearSnapShots(from: view)
    }
}



// Implementation
class SnapShotDrawingOnController: SnapShotsDrawing {
    
    weak var snapShotTapDelegate: SnapShotTapDelegate?
    
    func drawAllSnapShots(snapShots: [SnapShot], on view: UIView) {
        print("Drawing SnapShots")
        guard snapShots.count != 0 else {
            return
        }
        
        let viewWidth = view.frame.size.width
        let viewHeight = view.frame.size.height
        
        // If there is 1 snapshot, put it in the middle
        guard snapShots.count > 1 else {
            drawSingleSnapshot(x: viewWidth / 2, y: viewHeight / 2, tag: 0, on: view)
            return
        }
        
        // There are more than 1 snapshot
        // Get result
        let calculatedLocations = calculateDotLocation(from: snapShots, into: view)
        // Draw points
        calculatedLocations?.forEach{
            drawSingleSnapshot(x: $0.x, y: $0.y, tag: $0.tag, on: view)
        }
    }

    func drawSingleSnapshot(x: CGFloat, y: CGFloat, tag: Int, on view: UIView) {
        let pointsize: CGFloat = 16
        let dotView = UIView(frame: CGRect(x: x-pointsize/2,
                                           y: y-pointsize/2,
                                           width: pointsize,
                                           height: pointsize))
        dotView.backgroundColor = .white
        dotView.layer.cornerRadius = pointsize/2
        dotView.isUserInteractionEnabled = true
        dotView.tag = tag
        
        dotView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                            action: #selector(didTapDot(_:))))
        view.addSubview(dotView)
    }
    
    func calculateDotLocation(from snapShots: [SnapShot], into view: UIView) -> [Location]? {
        
        var location: [Location] = []
        print("I'm calculating scale from sanpshots.")
        // X
        let minXSnapShot = snapShots.min
        { $0.cameraTransform.translation.x < $1.cameraTransform.translation.x }
        let maxXSnapShot = snapShots.max
        { $0.cameraTransform.translation.x < $1.cameraTransform.translation.x }
        // Y
        let minYSnapShot = snapShots.min
        { $0.cameraTransform.translation.z < $1.cameraTransform.translation.z }
        let maxYSnapShot = snapShots.max
        { $0.cameraTransform.translation.z < $1.cameraTransform.translation.z }
        
        guard let minX = minXSnapShot?.cameraTransform.translation.x,
            let maxX = maxXSnapShot?.cameraTransform.translation.x,
            let minY = minYSnapShot?.cameraTransform.translation.z,
            let maxY = maxYSnapShot?.cameraTransform.translation.z else {
                return nil
        }
        
        // Get ready to fire 💪🏼
        let diffX = maxX - minX
        let diffY = maxY - minY
        
        var tag = 0
        snapShots.forEach {
            // Shift, normalize and scale
            let normX = ($0.cameraTransform.translation.x - minX) / diffX
            let normY = ($0.cameraTransform.translation.z - minY) / diffY
            let x: CGFloat = CGFloat(normX) * view.frame.size.width
            let y: CGFloat = CGFloat(normY) * view.frame.size.height
            let calculateLocation = Location(x: x, y: y, tag : tag)
            location.append(calculateLocation)
            tag += 1
        }
        
        return location
    }
    
    func clearSnapShots(from view: UIView) {
        print("cleaning")
        view.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    @objc
    func didTapDot(_ sender: UITapGestureRecognizer) {
        print("I'm in implementation")
        print("\(String(describing: sender.view?.tag))")
        // Send tag to controller to do the rest
        snapShotTapDelegate?.didTap(snapShot: sender.view!.tag)
    }
}

protocol SnapShotsDrawing {
    // Drawing
    func drawAllSnapShots(snapShots: [SnapShot], on view: UIView)
    func drawSingleSnapshot(x: CGFloat, y:CGFloat, tag: Int, on view: UIView)
    func calculateScale(from snapShots: [SnapShot], into view: UIView)
    func clearSnapShots(from view: UIView)
}
// Make these optional
extension SnapShotsDrawing {
    func drawSingleSnapshot(x: CGFloat, y:CGFloat, tag: Int, on view: UIView) {}
    func calculateScale(from snapShots: [SnapShot], into view: UIView){}
}

// Delegate for SnapShot Tapping
protocol SnapShotTapDelegate: class {
    func didTap(snapShot atIndex: Int)
}
