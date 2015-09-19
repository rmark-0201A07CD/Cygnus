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
	
	override func viewWillTransitionToSize(newSize: NSSize) {
		(self.view as? SKView)?.scene?.size = newSize
	}
	
	override func viewWillAppear() {
        super.viewWillAppear()
		
		guard let scene = (NSApplication.sharedApplication().delegate as? CXAppDelegate)?.initialScene(view.bounds.size) else { fatalError("CXAppDelegate Subclass Not Implemented") }

		scene.scaleMode = .AspectFill
		scene.viewController = self
		skView?.presentScene(scene)
		scene.didAppear()
        // Do view setup here.
    }
    
}
