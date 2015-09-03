//
//  CXViewController.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import Cocoa
import SpriteKit

class CXViewController: NSViewController {

	@IBOutlet var skView:SKView?
	
	override func viewWillAppear() {
        super.viewWillAppear()
		
		guard let sceneClass = (NSApplication.sharedApplication().delegate as? CXAppDelegate)?.initialSceneClass else { fatalError("Initial Scene Class Not Set") }
		let scene = sceneClass.init(size:view.bounds.size)

		scene.scaleMode = .AspectFill
		scene.viewController = self
		skView?.presentScene(scene)
        // Do view setup here.
    }
    
}
