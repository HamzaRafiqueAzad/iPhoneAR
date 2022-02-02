//
//  FocusSquare.swift
//  IphoneAR
//
//  Created by Hamza Rafique Azad on 27/1/22.
//

import SceneKit

class FocusSquare: SCNNode {
    
    var isClose: Bool = true {
        didSet {
            geometry?.firstMaterial?.diffuse.contents = self.isClose ? UIImage(named: "close.png") : UIImage(named: "open.png")
        }
    }
    
    override init() {
        super.init()
        
        let plane = SCNPlane(width: 0.1, height: 0.1)
        
        plane.firstMaterial?.diffuse.contents = UIImage(named: "close.png")
        plane.firstMaterial?.isDoubleSided = true
        
        geometry = plane
        
        eulerAngles.x = GLKMathDegreesToRadians(-90)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
