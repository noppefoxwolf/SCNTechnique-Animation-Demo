//
//  ViewController.swift
//  SCNTechnique+Animation
//
//  Created by Tomoya Hirano on 2019/12/12.
//  Copyright © 2019 Tomoya Hirano. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    
    let scnView: SCNView = .init()
    
    override func loadView() {
        super.loadView()
        view.addSubview(scnView)
        scnView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scnView.topAnchor.constraint(equalTo: view.topAnchor),
            scnView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scnView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scnView.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
    }
    lazy var technique: SCNTechnique = {
        if let path = Bundle.main.path(forResource: "Technique", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String : Any] {
            return SCNTechnique(dictionary: dict)!
        } else { preconditionFailure() }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        scnView.allowsCameraControl = true
        scnView.scene = SCNScene()
        scnView.scene?.background.contents = UIColor.green
        let boxNode = SCNNode(geometry: SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0))
        scnView.scene?.rootNode.addChildNode(boxNode)
        let cameraNode = SCNNode()
        cameraNode.camera = .init()
        cameraNode.position = .init(0, 5, 10)
        cameraNode.look(at: boxNode.position)
        scnView.scene?.rootNode.addChildNode(cameraNode)
        
        scnView.technique = technique
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("didTap")
        
        // set value
        //scnView.technique!.setObject(NSNumber(floatLiteral: 0.1), forKeyedSubscript: NSString(string: "valueSymbol"))
        
        // animation
        scnView.technique!.removeAllAnimations()
        let animation = CABasicAnimation(keyPath: "valueSymbol")
        animation.fromValue   = NSNumber(floatLiteral: 0.0)
        animation.toValue     = NSNumber(floatLiteral: 1.0)
        animation.duration = 5.0
        scnView.technique!.addAnimation(animation, forKey: "animation")
    }
}

