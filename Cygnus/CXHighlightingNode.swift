//
//  CXHighlightSpriteNode.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/21/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit

open class CXHighlightingNode: SKSpriteNode {

	open func didBeginHighilighting() {
		#if os(tvOS)
		texture = highlightTexture
		#endif
	}
	open func didEndHighlighting() {
		#if os(tvOS)
		texture = normalTexture
		#endif
	}

	open func highlight(){
		CXHighlightingNode.currentlyHighlightedNode = self
		isHighlighted = true
	}
	
	open var highlightTexture:SKTexture?
	open var nomralTexture:SKTexture?
	
	open internal(set) var isHighlighted = false {
		didSet {
			if isHighlighted {
				didBeginHighilighting()
				(parent?.parent as? CXScrollNode)?.scrollTo(self)
			} else {
				didEndHighlighting()
			}
		}
	}

	open static var currentlyHighlightedNode:CXHighlightingNode? {
		willSet { currentlyHighlightedNode?.isHighlighted = false }
		didSet { currentlyHighlightedNode?.isHighlighted = true }
	}
	
	final public weak var leftHighlight:CXHighlightingNode?
	final public weak var rightHighlight:CXHighlightingNode?
	final public weak var upHighlight:CXHighlightingNode?
	final public weak var downHighlight:CXHighlightingNode?
	
}
