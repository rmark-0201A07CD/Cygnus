//
//  CXScrollNode.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit

/**
Do not add children to the scroll Node. Instead add Children to its Content Node
*/

public class CXScrollNode: SKNode {
	
	final public internal(set) var content:SKNode = SKNode()
	private let background:SKSpriteNode
	
	public init(size:CGSize) {
		background = SKSpriteNode(color: almostClearColor, size: size)
		self.size = size
		super.init()
		addChild(background)
		mask.maskNode = SKSpriteNode(color: CXColor.whiteColor(), size: size)
		addChild(mask)
		mask.addChild(content)
		userInteractionEnabled = true
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override public func removeAllChildren() {
		content.removeAllChildren()
	}
	
/// Scroll Bounds
	var mask:SKCropNode = SKCropNode()
	final public var contentSize = CGSize() {
		didSet {
			content.constraints = [
				SKConstraint.positionX(SKRange(lowerLimit: min(background.size.width-contentSize.width,0), upperLimit: 0)),
				SKConstraint.positionY(SKRange(lowerLimit: min(background.size.height-contentSize.height,0), upperLimit: 0))
			]
			background.size = size
			(mask.maskNode as? SKSpriteNode)?.size = size
		}
	}
	
	final public var size:CGSize{
		didSet {
			background.size = size
			(mask.maskNode as? SKSpriteNode)?.size = size
			content.constraints = [
				SKConstraint.positionX(SKRange(lowerLimit: min(background.size.width-contentSize.width,0), upperLimit: 0)),
				SKConstraint.positionY(SKRange(lowerLimit: min(background.size.height-contentSize.height,0), upperLimit: 0))
			]
		}
	}
/// Scrolling
	
	private var startScrollPosition:CGPoint?
	private var startScrollPoint:CGPoint?
	
	#if os(iOS)
	override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		for node in nodesAtPoint(touches.first?.locationInNode(self) ?? CGPoint()) {
			node.touchesBegan(touches,withEvent:event)
		}
		startScrollPoint = touches.first?.locationInNode(self)
		startScrollPosition = content.position
	}
	override public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
		for node in nodesAtPoint(touches.first?.locationInNode(self) ?? CGPoint()) {
			node.touchesMoved(touches,withEvent:event)
		}
		guard let newPoint = touches.first?.locationInNode(self), let oldPoint =  startScrollPoint, startPosition = startScrollPosition else { return }
		content.position = startPosition + newPoint - oldPoint
	}
	override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		for node in nodesAtPoint(touches.first?.locationInNode(self) ?? CGPoint()) {
			node.touchesEnded(touches,withEvent:event)
		}
		startScrollPosition = nil
		startScrollPoint = nil
	}
	override public func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
		touchesEnded(touches ?? [], withEvent: event)
	}
	#elseif os(OSX)
	override public func mouseDown(theEvent: NSEvent) {
		for node in nodesAtPoint(theEvent.locationInNode(self)) {
			node.mouseDown(theEvent)
		}
		startScrollPoint = theEvent.locationInNode(self)
		startScrollPosition = content.position
	}
	private func moveScroll(theEvent:NSEvent){
		let newPoint = theEvent.locationInNode(self)
		guard let oldPoint = startScrollPoint, startPosition = startScrollPosition else { return }
		content.position = startPosition + newPoint - oldPoint
	}
	override public func mouseDragged(theEvent: NSEvent) {
		for node in nodesAtPoint(theEvent.locationInNode(self)) {
			node.mouseDragged(theEvent)
		}
		moveScroll(theEvent)
	}
	override public func mouseUp(theEvent: NSEvent) {
		for node in nodesAtPoint(theEvent.locationInNode(self)) {
			node.mouseUp(theEvent)
		}
		startScrollPosition = nil
		startScrollPoint = nil
	}
	#endif
}




























