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
		mask.maskNode = SKSpriteNode(color: CXColor.white(), size: size)
		addChild(mask)
		mask.addChild(content)
		isUserInteractionEnabled = true
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
	
	private var startScrollPosition:CGPoint?
	private var startScrollPoint:CGPoint?
	
	#if os(iOS)
	override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for node in nodes(at: touches.first?.location(in: self) ?? CGPoint()) {
			node.touchesBegan(touches,with:event)
		}
		startScrollPoint = touches.first?.location(in: self)
		startScrollPosition = content.position
	}
	override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for node in nodes(at: touches.first?.location(in: self) ?? CGPoint()) {
			node.touchesMoved(touches,with:event)
		}
		guard let newPoint = touches.first?.location(in: self), let oldPoint =  startScrollPoint, startPosition = startScrollPosition else { return }
		content.position = startPosition + newPoint - oldPoint
	}
	override public func touchesEnded(_ touches: Set<UITouch>, with
		event: UIEvent?) {
		for node in nodes(at: touches.first?.location(in: self) ?? CGPoint()) {
			node.touchesEnded(touches,with:event)
		}
		startScrollPosition = nil
		startScrollPoint = nil
	}
	override public func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
		touchesEnded(touches ?? [], with: event)
	}
	#elseif os(OSX)
	override public func mouseDown(_ theEvent: NSEvent) {
		for node in nodes(at: theEvent.location(in: self)) {
			node.mouseDown(theEvent)
		}
		startScrollPoint = theEvent.location(in: self)
		startScrollPosition = content.position
	}
	private func moveScroll(theEvent:NSEvent){
		let newPoint = theEvent.location(in: self)
		guard let oldPoint = startScrollPoint, startPosition = startScrollPosition else { return }
		content.position = startPosition + newPoint - oldPoint
	}
	override public func mouseDragged(_ theEvent: NSEvent) {
		for node in nodes(at: theEvent.location(in: self)) {
			node.mouseDragged(theEvent)
		}
		moveScroll(theEvent: theEvent)
	}
	override public func mouseUp(_ theEvent: NSEvent) {
		for node in nodes(at: theEvent.location(in: self)) {
			node.mouseUp(theEvent)
		}
		startScrollPosition = nil
		startScrollPoint = nil
	}
	#endif
	public func moveTo(node:SKSpriteNode){
		content.position.x = max (-(node.position.x - node.size.width), content.position.x)
		content.position.x = min (-(node.position.x + node.size.width-size.width), content.position.x)
		
		content.position.y = max (-(node.position.y - node.size.height), content.position.y)
		content.position.y = min (-(node.position.y + node.size.height-size.height), content.position.y)

	}
}




























