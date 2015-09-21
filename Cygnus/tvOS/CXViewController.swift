//
//  CXViewController.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit
import UIKit

class CXViewController: UIViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let skView = view as? SKView

		guard let scene = (UIApplication.sharedApplication().delegate as? CXAppDelegate)?.initialScene(view.bounds.size) else { fatalError("CXAppDelegate Subclass Not Implemented") }
		
		scene.viewController = self
		skView?.presentScene(scene)
		
		//Set up Swipe Support
		let rightSwipe = UISwipeGestureRecognizer(target: self, action:"detectRightSwipe:")
		rightSwipe.direction = .Right
		view.addGestureRecognizer(rightSwipe)
		
		let leftSwipe = UISwipeGestureRecognizer(target: self, action:"detectLeftSwipe:")
		leftSwipe.direction = .Left
		view.addGestureRecognizer(leftSwipe)
		
		let upSwipe = UISwipeGestureRecognizer(target: self, action:"detectUpSwipe:")
		upSwipe.direction = .Up
		view.addGestureRecognizer(upSwipe)
		
		let downSwipe = UISwipeGestureRecognizer(target: self, action:"detectDownSwipe:")
		downSwipe.direction = .Down
		view.addGestureRecognizer(downSwipe)
		
	}
	
	func detectRightSwipe(){
		guard let scene = (view as? SKView)?.scene as? CXScene else { return }
		guard scene.swipeToHighlightEnabled else {
			scene.swipedRight()
			return
		}
		guard let old = CXHighlightingNode.currentHighlightedNode, new = old.rightHighlight else { return }
		new.highlight()
		new.leftHighlight = old
	}
	func detectLeftSwipe(){
		guard let scene = (view as? SKView)?.scene as? CXScene else { return }
		guard scene.swipeToHighlightEnabled else {
			scene.swipedLeft()
			return
		}
		guard let old = CXHighlightingNode.currentHighlightedNode, new = old.leftHighlight else { return }
		new.highlight()
		new.rightHighlight = old
	}
	func detectUpSwipe(){
		guard let scene = (view as? SKView)?.scene as? CXScene else { return }
		guard scene.swipeToHighlightEnabled else {
			scene.swipedUp()
			return
		}
		guard let old = CXHighlightingNode.currentHighlightedNode, new = old.upHighlight else { return }
		new.highlight()
		new.downHighlight = old
	}
	func detectDownSwipe(){
		guard let scene = (view as? SKView)?.scene as? CXScene else { return }
		guard scene.swipeToHighlightEnabled else {
			scene.swipedDown()
			return
		}
		guard let old = CXHighlightingNode.currentHighlightedNode, new = old.downHighlight else { return }
		new.highlight()
		new.upHighlight = old
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}