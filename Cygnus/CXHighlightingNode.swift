//
//  CXHighlightSpriteNode.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/21/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit

public class CXHighlightingNode: SKSpriteNode {

	public func didBeginHighilighting() {
		texture = highlightTexture
	}
	public func didEndHighlighting() {
		texture = normalTexture
	}

	public func highlight(){
		CXHighlightingNode.currentHighlightedNode = self
	}
	
	public var highlightTexture:SKTexture?
	public var nomralTexture:SKTexture?
	
	public internal(set) var isHighlighted = false {
		didSet {
			if isHighlighted {
				didBeginHighilighting()
				(parent?.parent as? CXScrollNode)?.makeChildNodeVisible(self)
			} else {
				didEndHighlighting()
			}
		}
	}

	public static var currentHighlightedNode:CXHighlightingNode? {
		willSet { currentHighlightedNode?.isHighlighted = false }
		didSet { currentHighlightedNode?.isHighlighted = true }
	}
	
	final public weak var leftHighlight:CXHighlightingNode?
	final public weak var rightHighlight:CXHighlightingNode?
	final public weak var upHighlight:CXHighlightingNode?
	final public weak var downHighlight:CXHighlightingNode?
	
}
