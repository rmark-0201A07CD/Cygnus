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

		guard let scene = (UIApplication.shared().delegate as? CXAppDelegate)?.initialScene(size: view.bounds.size) else { fatalError("CXAppDelegate Subclass Not Implemented") }
		
		scene.viewController = self
		skView?.presentScene(scene)
		
		//Set up Swipe Support
		let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(CXViewController.detectRightSwipe(_:)))
		rightSwipe.direction = .right
		view.addGestureRecognizer(rightSwipe)
		
		let leftSwipe = UISwipeGestureRecognizer(target: self, action:#selector(CXViewController.detectLeftSwipe(_:)))
		leftSwipe.direction = .left
		view.addGestureRecognizer(leftSwipe)
		
		let upSwipe = UISwipeGestureRecognizer(target: self, action:#selector(CXViewController.detectUpSwipe(_:)))
		upSwipe.direction = .up
		view.addGestureRecognizer(upSwipe)
		
		let downSwipe = UISwipeGestureRecognizer(target: self, action:#selector(CXViewController.detectDownSwipe(_:)))
		downSwipe.direction = .down
		view.addGestureRecognizer(downSwipe)
		
	}
	override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
		guard let scene = (view as? SKView)?.scene as? CXScene else { return }
		guard scene.swipeToHighlightEnabled, let button = CXHighlightingNode.currentHighlightedNode as? CXButtonNode else {
			scene.pressesEnded(presses, with: event)
			return
		}
		guard !(presses.filter{$0.type == .select}).isEmpty else { return }
		button.action?(button)
	}
	
	func detectRightSwipe(_ sender:UIGestureRecognizer){
		guard sender.state == .ended, let scene = (view as? SKView)?.scene as? CXScene else { return }
		guard scene.swipeToHighlightEnabled else {
			(scene as? CXSwipeResponder)?.swipedRight()
			return
		}
		guard let old = CXHighlightingNode.currentHighlightedNode, new = old.rightHighlight else { return }
		new.highlight()
		new.leftHighlight = old
	}
	func detectLeftSwipe(_ sender:UIGestureRecognizer){
		guard sender.state == .ended, let scene = (view as? SKView)?.scene as? CXScene else { return }
		guard scene.swipeToHighlightEnabled else {
			(scene as? CXSwipeResponder)?.swipedLeft()
			return
		}
		guard let old = CXHighlightingNode.currentHighlightedNode, new = old.leftHighlight else { return }
		new.highlight()
		new.rightHighlight = old
	}
	func detectUpSwipe(_ sender:UIGestureRecognizer){
		guard sender.state == .ended, let scene = (view as? SKView)?.scene as? CXScene else { return }
		guard scene.swipeToHighlightEnabled else {
			(scene as? CXSwipeResponder)?.swipedUp()
			return
		}
		guard let old = CXHighlightingNode.currentHighlightedNode, new = old.upHighlight else { return }
		new.highlight()
		new.downHighlight = old
	}
	func detectDownSwipe(_ sender:UIGestureRecognizer){
		guard sender.state == .ended, let scene = (view as? SKView)?.scene as? CXScene else { return }
		guard scene.swipeToHighlightEnabled else {
			(scene as? CXSwipeResponder)?.swipedDown()
			return
		}
		guard let old = CXHighlightingNode.currentHighlightedNode, new = old.downHighlight else { return }
		new.highlight()
		new.upHighlight = old
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
