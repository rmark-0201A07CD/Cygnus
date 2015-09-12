//
//  CXButtonNode.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit

public class CXButtonNode:SKSpriteNode {

/// Touch Detection
	final public var action:((CXButtonNode)->())? {
		didSet { userInteractionEnabled = action != nil }
	}
	
	private var isPressed = false
	#if os(iOS)
	override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
		isPressed = true
	}
	override public func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
		guard isPressed, let parent = parent, point = touches.first?.locationInNode(parent) where containsPoint(point) else { return }
		isPressed = false
		action?(self)
	}
	#elseif os(OSX)
	override public func mouseDown(theEvent: NSEvent) {
		isPressed = true
	}
	override public func mouseUp(theEvent: NSEvent) {
		theEvent
		guard isPressed, let parent = parent where containsPoint(theEvent.locationInNode(parent)) else { return }
		isPressed = false
		action?(self)
	}
	#endif
	

/// Button Label
	
	public class func buttonWithLabel(text:String)->CXButtonNode {
		let button = CXButtonNode(color: almostClearColor, size: CGSize(width: 100, height: 50))
		button.text = text
		return button
	}
	
	private var label:SKLabelNode?
	
	public var text:String = "" {
		didSet {
			setupLabel()
			label?.text = text
		}
	}
	public var fontName:String? {
		didSet {
			setupLabel()
			label?.fontName = fontName
		}
	}
	public var fontColor:CXColor? {
		didSet {
			setupLabel()
			label?.fontColor = fontColor
		}
	}
	
	private func setupLabel(){
		guard label == nil else { return }
		let newLabel = SKLabelNode(text:text)
		newLabel.fontSize = 22
		newLabel.verticalAlignmentMode = .Center
		label = newLabel
		addChild(newLabel)
	}
	
	
	
	
}
