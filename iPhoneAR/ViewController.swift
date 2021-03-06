//
//  ViewController.swift
//  IphoneAR
//
//  Created by Hamza Rafique Azad on 23/1/22.
//

import UIKit
import SceneKit
import SceneKit.ModelIO
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!

    
    var focusSquare: FocusSquare?
    
    var screenCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.isHidden = true
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
        screenCenter = view.center
        
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        let viewCenter = CGPoint(x: size.width/2, y: size.height/2)
        
        screenCenter = viewCenter
    }
    
    @IBOutlet weak var addButton: UIButton!
    func updateFocusSquare() {
        
        guard let focusSquareLocal = focusSquare else {return}
        
        let hitTest = sceneView.hitTest(screenCenter, types: .existingPlaneUsingExtent)
        
        if let hitTestResult = hitTest.first {
            
            let canAddNewModel = hitTestResult.anchor is ARPlaneAnchor
            focusSquareLocal.isClose = canAddNewModel
            addButton.isHidden = false
            
        } else {
            addButton.isHidden = true
            focusSquareLocal.isClose = false
        }
        
    }

    // MARK: - ARSCNViewDelegate
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
