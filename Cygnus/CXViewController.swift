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
	
	func resizeScene(_ notification:NSNotification?){
		guard lastResize < CFAbsoluteTimeGetCurrent() - 0.1 else { return }
		lastResize = CFAbsoluteTimeGetCurrent()
		//Calculate Scene size
		skView?.scene?.size = skView?.bounds.size ?? CGSize()
	}
	
	
	override func viewWillAppear() {
        super.viewWillAppear()
		
		guard let scene = (NSApplication.shared().delegate as? CXAppDelegate)?.initialScene(size: view.bounds.size) else { fatalError("CXAppDelegate Subclass Not Implemented") }
		
		NotificationCenter.default().addObserver(self, selector: #selector(CXViewController.resizeScene(_:)),
			name: .NSWindowDidResize,object: view.window)

		scene.scaleMode = .aspectFill
		scene.viewController = self
		skView?.presentScene(scene)
        // Do view setup here.
    }
    
}
