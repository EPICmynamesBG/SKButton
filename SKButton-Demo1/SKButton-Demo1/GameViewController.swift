//
//  GameViewController.swift
//  SKButton-Demo1
//
//  Created by Brandon Groff on 12/10/15.
//  Copyright (c) 2015 Brandon Groff. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

/* A modified version of creating a GameScene.
* Note that GameScene is being initialized with size: Device.screenSize.
* This must be done in order to use the SKButtonPosition class as intended.
*/
        let skView: SKView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
//        skView.ignoresSiblingOrder = true
        let scene = GameScene(size: Device.screenSize)
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
        
/* 
 Note: The below is the auto-generated GameScene creation.
*/
        
//        if let scene = GameScene(fileNamed: "GameScene") {
//            // Configure the view.
//            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
//            
//            /* Sprite Kit applies additional optimizations to improve rendering performance */
//            skView.ignoresSiblingOrder = true
//            
//            /* Set the scale mode to scale to fit the window */
//            scene.scaleMode = .AspectFill
//            
//            skView.presentScene(scene)
//        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
