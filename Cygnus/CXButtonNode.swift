//
//  CXButtonNode.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit


open class CXButtonNode: CXHighlightingNode {

/// Touch Detection
	final public var action:((CXButtonNode)->())? {
		didSet { isUserInteractionEnabled = action != nil }
	}
	
	fileprivate var isPressed = false
	#if os(iOS)
	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		isPressed = true
	}
	override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard isPressed, let parent = parent, let point = touches.first?.location(in: parent), contains(point) else { return }
		isPressed = false
		action?(self)
	}
	#elseif os(OSX)
	override open func mouseDown(with theEvent: NSEvent) {
		isPressed = true
	}
	override open func mouseUp(with theEvent: NSEvent) {
		guard isPressed, let parent = parent, contains(theEvent.location(in: parent)) else { return }
		isPressed = false
		action?(self)
	}
	#endif
	

/// Button Label
	
	open class func makeButton(label text:String)->CXButtonNode {
		let button = CXButtonNode(color: almostClearColor, size: CGSize(width: 100, height: 50))
		button.text = text
		return button
	}
	
	fileprivate var label:SKLabelNode?
	
	open var text:String = "" {
		didSet {
			setupLabel()
			label?.text = text
		}
	}
	open var fontName:String? {
		didSet {
			setupLabel()
			label?.fontName = fontName
		}
	}
	open var fontColor:CXColor? {
		didSet {
			setupLabel()
			label?.fontColor = fontColor
		}
	}
	open var fontSize:CGFloat = 22.0 {
		didSet {
			setupLabel()
			label?.fontSize = fontSize
		}
	}
	
	fileprivate func setupLabel(){
		guard label == nil else { return }
		let newLabel = SKLabelNode(text:text)
		newLabel.fontSize = 22.0
		newLabel.verticalAlignmentMode = .center
		label = newLabel
		addChild(newLabel)
	}
	
	
	
	
}
