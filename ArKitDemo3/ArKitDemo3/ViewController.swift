//
//  ViewController.swift
//  ArKitDemo3
//
//  Created by Readify BNE Shared on 6/7/17.
//  Copyright © 2017 Readify. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var redMaterial : SCNMaterial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        redMaterial = SCNMaterial()
        redMaterial.diffuse.contents = UIColor.red
        
        redMaterial.diffuse.contents = UIColor(red: 0.67, green: 0.0, blue: 0.0, alpha: 0.5)
    }
    
    func renderer(_ renderer: SCNSceneRenderer,
                  didAdd node: SCNNode,
                  for anchor: ARAnchor)
    {
        if let planeAnchor = anchor as? ARPlaneAnchor{
            print("anchor")
            print(planeAnchor.extent)
            print(planeAnchor.center)
            print(planeAnchor.alignment)
            
            let box = SCNBox(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.y), length: CGFloat(planeAnchor.extent.z), chamferRadius: 0.01)
            box.materials = [redMaterial]
            
            node.geometry = box;
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer,
                  didUpdate node: SCNNode,
                  for anchor: ARAnchor){
        if let planeAnchor = anchor as? ARPlaneAnchor{
            if let box = node.geometry as? SCNBox{
                box.width = CGFloat(planeAnchor.extent.x);
                box.height = CGFloat(planeAnchor.extent.y);
                box.length = CGFloat(planeAnchor.extent.z);
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
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
