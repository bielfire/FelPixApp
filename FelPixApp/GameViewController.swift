//
//  GameViewController.swift
//  FelPixApp
//
//  Created by Gabriel Jacinto on 22/10/19.
//  Copyright © 2019 Gabriel Jacinto. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let size = UIScreen.main.bounds.size
        let scene = MenuInicio(size: size)
        scene.scaleMode = .aspectFill
        
        
        let skView = self.view as! SKView
        skView.showsNodeCount = false
        skView.showsPhysics = true
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }
 
//override func shoudAutorotate() -> Bool {
//        return true
    
//    }
//override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
//    if UIDevice.current.userInterfaceIdiom == .phone {
//        return .allButUpsideDown
//    } else {
//            return .all
//        }
//
//}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func prefersStatusBarHidden() -> Bool {
        return true
    }
}


