//
//  CXViewController.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit
import UIKit
import iAd

class CXViewController: UIViewController, ADBannerViewDelegate {
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	
	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		guard let scene = (self.view as? SKView)?.scene else { return }
		
		DispatchQueue.main.after(when: DispatchTime.now() + .seconds(Int(coordinator.transitionDuration()/2))){
			
			scene.size = size
		}
	}
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let skView = view as? SKView
		skView?.isMultipleTouchEnabled = false

		guard let scene = (UIApplication.shared().delegate as? CXAppDelegate)?.initialScene(size: view.bounds.size) else { fatalError("CXAppDelegate Subclass Not Implemented") }
		
		scene.viewController = self
		skView?.presentScene(scene)
    }
	
}
