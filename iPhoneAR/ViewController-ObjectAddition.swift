//
//  ViewController-ObjectAddition.swift
//  IphoneAR
//
//  Created by Hamza Rafique Azad on 28/1/22.
//

import UIKit
import SceneKit
import ARKit
import SceneKit.ModelIO

extension ViewController {
    
    fileprivate func getModel(named name: String) -> SCNNode? {
        
        guard let url = Bundle.main.url(forResource: "art.scnassets/\(name)", withExtension: "usdz") else {return nil}
        
        let scene = try! SCNScene(url: url, options: [.checkConsistency: true])
        
        guard let model = scene.rootNode.childNode(withName: "scene", recursively: false) else {return nil}
        
        model.name = name
        model.scale = SCNVector3(0.001, 0.001, 0.001)
        model.light = SCNLight()
        model.light?.type = .directional
        
        return model
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modelSegue" {
            let mVC = segue.destination as! ModelsTableViewController
            mVC.delegate = self
        }
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        print("Add Button Tapped")
        
        performSegue(withIdentifier: "modelSegue", sender: self)
        
    }
    
    func addModel(named name: String) {
        print("Model will add")
        guard focusSquare != nil else {return}
        
        let modelName = name
        
        guard let model = getModel(named: modelName) else {
            print("Unable to load model from file")
            return
        }
        
        let hitTest = sceneView.hitTest(screenCenter, types: .existingPlaneUsingExtent)
        
        guard let worldTransformColumn3 = hitTest.first?.worldTransform.columns.3 else {return}
        
        model.position = SCNVector3(worldTransformColumn3.x, worldTransformColumn3.y, worldTransformColumn3.z)
        
        sceneView.scene.rootNode.addChildNode(model)
        
        print("Model Name: \(modelName) added")
    }
    
    
}
