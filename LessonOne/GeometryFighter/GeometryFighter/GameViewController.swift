//
//  GameViewController.swift
//  GeometryFighter
//
//  Created by chenzhipeng on 2018/6/24.
//  Copyright © 2018 perry. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {

    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var spawnTime: TimeInterval = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        spawnShape()
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    func setupView() {
        scnView = self.view as! SCNView
        // 1 showStatistics enables a real-time statistics panel at the bottom of your scene.
        scnView.showsStatistics = true

        scnView.allowsCameraControl = true

        scnView.autoenablesDefaultLighting = true
        
        scnView.delegate = self
        
        scnView.isPlaying = true

    }

    func setupScene() {
        scnScene = SCNScene()

        scnView.scene = scnScene

        scnScene.background.contents = "GeometryFighter.scnassets/Textures/Background_Diffuse.png"
    }

    func setupCamera() {
        // create an empty SCNNode and assign it to cameraNode
        cameraNode = SCNNode()

        // create a new SCNCamera object and assign it to the camera property of cameraNode
        cameraNode.camera = SCNCamera()

        // set the position of the camera at (0 0 10)
        cameraNode.position = SCNVector3(x: 0, y: -5, z: 10)

        // add cameraNode to the scene as a child node of the scene's root node.
        scnScene.rootNode.addChildNode(cameraNode)
        
    }

    func spawnShape() {
        // 1
        var geometry: SCNGeometry

        // 2
        switch ShapeType.random() {
        default:
            // 3
            geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        }

        geometry.materials.first?.diffuse.contents = UIColor.random()

        // 4
        let geometryNode = SCNNode(geometry: geometry)

        geometryNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil);

        let randomX = Float.random(min: -2, max: 2);
        let randomY = Float.random(min: 10, max: 18);
        
        let force = SCNVector3(x: randomX, y: randomY, z: 0);
        
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05);
        
        let torque = SCNVector4(x: 0.2, y: 0.2, z: 0.2, w: 0.5);
        
//        geometryNode.physicsBody?.applyForce(force, at: position, asImpulse: true);
        
        geometryNode.physicsBody?.applyTorque(torque, asImpulse: true);
        
        // 5
        scnScene.rootNode.addChildNode(geometryNode)
        
    }
    
    func cleanScene() {
        for node in scnScene.rootNode.childNodes {
            if node.presentation.position.y < -2 {
                // 3
                node.removeFromParentNode()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}

extension GameViewController: SCNSceneRendererDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if time > spawnTime {
            print("time is \(time), spawnTime is \(spawnTime)");
            spawnShape()
            
            // 2
            spawnTime = time + TimeInterval(Float.random(min: 0.2, max: 1.5))
        }
        cleanScene()

    }
    
}
