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
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)

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
        // 4
        let geometryNode = SCNNode(geometry: geometry)

        // 5
        scnScene.rootNode.addChildNode(geometryNode)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
