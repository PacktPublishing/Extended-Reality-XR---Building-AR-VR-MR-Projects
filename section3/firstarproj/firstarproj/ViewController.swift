//
//  ViewController.swift
//  firstarproj
//
//  Created by Parul Bansal on 12/27/18.
//  Copyright © 2018 Parul Bansal. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet weak var sceneView: ARSCNView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
        sceneView.debugOptions = [.showFeaturePoints]
        sceneView.delegate = self
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        if anchor is ARPlaneAnchor {
            let arPlaneAnchor = anchor as! ARPlaneAnchor
           
            let arPlane = SCNPlane(width: CGFloat(arPlaneAnchor.extent.x), height: CGFloat(arPlaneAnchor.extent.z))
            
            arPlane.materials.first?.diffuse.contents = UIImage(named: "art.scnassets/square.png")
            
            let planeNode = SCNNode()
            planeNode.position = SCNVector3(arPlaneAnchor.center.x, 0, arPlaneAnchor.center.z)
            
            planeNode.eulerAngles.x = -.pi/2
            
            planeNode.geometry = arPlane
            node.addChildNode(planeNode)
            
        } else {
            //do nothing
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchBegan = touches.first{
            let touchLoc = touchBegan.location(in: sceneView)
            
            let hitTestResults = sceneView.hitTest(touchLoc, types: .existingPlaneUsingExtent)
            
            if let hitResult = hitTestResults.first {
                let orangeScene = SCNScene(named: "art.scnassets/Orange.scn")
                
                if let orangeNode = orangeScene?.rootNode.childNode(withName: "Orange", recursively: true)
                {
                    orangeNode.scale = SCNVector3(0.1, 0.1, 0.1)
                    orangeNode.position = SCNVector3(x: hitResult.worldTransform.columns.3.x, y: hitResult.worldTransform.columns.3.y, z: hitResult.worldTransform.columns.3.z)
                    
                    sceneView.scene.rootNode.addChildNode(orangeNode)
                }
            }
            
        }
    }
    
    
    @IBAction func addCube(_ sender: Any) {
        
        let orangeScene = SCNScene(named: "art.scnassets/Orange.scn")
        
        if let orangeNode = orangeScene?.rootNode.childNode(withName: "Orange", recursively: true)
        {
            orangeNode.scale = SCNVector3(0.1, 0.1, 0.1)
            orangeNode.position = SCNVector3(0, 0, -0.2)
            
            sceneView.scene.rootNode.addChildNode(orangeNode)
        }
        
        
        
//        let scene = SCNScene()
//
//        let cube = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.02))
//        cube.position = SCNVector3(0, 0, -0.2)
//
//    cube.geometry?.materials.first?.diffuse.contents = UIColor.orange
//
//        scene.rootNode.addChildNode(cube)
//
//        sceneView.autoenablesDefaultLighting = true
//        sceneView.scene = scene
    }
    
}

