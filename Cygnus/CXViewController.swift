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
	
	private var lastResize = CFAbsoluteTimeGetCurrent()
	func resizeScene(notification:NSNotification?){
		guard lastResize < CFAbsoluteTimeGetCurrent() - 0.1 else { return }
		lastResize = CFAbsoluteTimeGetCurrent()
		//Calculate Scene size
		skView?.scene?.size = skView?.bounds.size ?? CGSize()
		print("resize")
	}
	
	
	override func viewWillAppear() {
        super.viewWillAppear()
		
		guard let scene = (NSApplication.sharedApplication().delegate as? CXAppDelegate)?.initialScene(view.bounds.size) else { fatalError("CXAppDelegate Subclass Not Implemented") }
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "resizeScene:",
			name: NSWindowDidResizeNotification,object: view.window)

		scene.scaleMode = .AspectFill
		scene.viewController = self
		skView?.presentScene(scene)
        // Do view setup here.
    }
    
}
