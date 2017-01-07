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

open class CXScrollNode: SKNode {

	final public internal(set) var content:SKNode = SKNode()
	fileprivate let background:SKSpriteNode
	
	public init(size:CGSize) {
		background = SKSpriteNode(color: almostClearColor, size: size)
		self.size = size
		super.init()
		addChild(background)
		mask.maskNode = SKSpriteNode(color: CXColor.white, size: size)
		addChild(mask)
		mask.addChild(content)
		isUserInteractionEnabled = true
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override open func removeAllChildren() {
		content.removeAllChildren()
	}
	
/// Scroll Bounds
	var mask:SKCropNode = SKCropNode()
	final public var contentSize = CGSize() {
		didSet {
			content.constraints = [
				SKConstraint.positionX(SKRange(lowerLimit: min(background.size.width/2-contentSize.width,0), upperLimit: 0)),
				SKConstraint.positionY(SKRange(lowerLimit: min(background.size.height/2-contentSize.height,0), upperLimit: 0))
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
	
	fileprivate var startScrollPosition:CGPoint?
	fileprivate var startScrollPoint:CGPoint?
	
	#if os(iOS)
	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for node in nodes(at: touches.first?.location(in: self) ?? CGPoint()) {
			node.touchesBegan(touches,with:event)
		}
		startScrollPoint = touches.first?.location(in: self)
		startScrollPosition = content.position
	}
	override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for node in nodes(at: touches.first?.location(in: self) ?? CGPoint()) {
			node.touchesMoved(touches,with:event)
		}
		guard let newPoint = touches.first?.location(in: self), let oldPoint =  startScrollPoint, let startPosition = startScrollPosition else { return }
		content.position = startPosition + newPoint - oldPoint
	}
	override open func touchesEnded(_ touches: Set<UITouch>, with
		event: UIEvent?) {
		for node in nodes(at: touches.first?.location(in: self) ?? CGPoint()) {
			node.touchesEnded(touches,with:event)
		}
		startScrollPosition = nil
		startScrollPoint = nil
	}
	override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		touchesEnded(touches , with: event)
	}
	#elseif os(OSX)
	override open func mouseDown(with theEvent: NSEvent) {
		for node in nodes(at: theEvent.location(in: self)) {
			node.mouseDown(with: theEvent)
		}
		startScrollPoint = theEvent.location(in: self)
		startScrollPosition = content.position
	}
	private func moveScroll(theEvent:NSEvent){
		let newPoint = theEvent.location(in: self)
		guard let oldPoint = startScrollPoint, let startPosition = startScrollPosition else { return }
		content.position = startPosition + newPoint - oldPoint
	}
	override open func mouseDragged(with theEvent: NSEvent) {
		for node in nodes(at: theEvent.location(in: self)) {
			node.mouseDragged(with: theEvent)
		}
		moveScroll(theEvent: theEvent)
	}
	override open func mouseUp(with theEvent: NSEvent) {
		for node in nodes(at: theEvent.location(in: self)) {
			node.mouseUp(with: theEvent)
		}
		startScrollPosition = nil
		startScrollPoint = nil
	}
	#endif
	open func scrollTo(_ node:SKSpriteNode){
		content.position.x = max (-(node.position.x - node.size.width), content.position.x)
		content.position.x = min (-(node.position.x + node.size.width-size.width), content.position.x)
		
		content.position.y = max (-(node.position.y - node.size.height), content.position.y)
		content.position.y = min (-(node.position.y + node.size.height-size.height), content.position.y)

	}
}




























