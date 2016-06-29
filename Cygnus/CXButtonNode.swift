//
//  CXButtonNode.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit


public class CXButtonNode: CXHighlightingNode {

/// Touch Detection
	final public var action:((CXButtonNode)->())? {
		didSet { isUserInteractionEnabled = action != nil }
	}
	
	private var isPressed = false
	#if os(iOS)
	override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		isPressed = true
	}
	override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard isPressed, let parent = parent, point = touches.first?.location(in: parent) where contains(point) else { return }
		isPressed = false
		action?(self)
	}
	#elseif os(OSX)
	override public func mouseDown(_ theEvent: NSEvent) {
		isPressed = true
	}
	override public func mouseUp(_ theEvent: NSEvent) {
		guard isPressed, let parent = parent where contains(theEvent.location(in: parent)) else { return }
		isPressed = false
		action?(self)
	}
	#endif
	

/// Button Label
	
	public class func makeButton(label text:String)->CXButtonNode {
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
	public var fontSize:CGFloat = 22.0 {
		didSet {
			setupLabel()
			label?.fontSize = fontSize
		}
	}
	
	private func setupLabel(){
		guard label == nil else { return }
		let newLabel = SKLabelNode(text:text)
		newLabel.fontSize = 22.0
		newLabel.verticalAlignmentMode = .center
		label = newLabel
		addChild(newLabel)
	}
	
	
	
	
}
