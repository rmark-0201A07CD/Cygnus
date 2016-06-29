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
		#if os(tvOS)
		texture = highlightTexture
		#endif
	}
	public func didEndHighlighting() {
		#if os(tvOS)
		texture = normalTexture
		#endif
	}

	public func highlight(){
		CXHighlightingNode.currentlyHighlightedNode = self
		isHighlighted = true
	}
	
	public var highlightTexture:SKTexture?
	public var nomralTexture:SKTexture?
	
	public internal(set) var isHighlighted = false {
		didSet {
			if isHighlighted {
				didBeginHighilighting()
				(parent?.parent as? CXScrollNode)?.makeChildNodeVisible(node: self)
			} else {
				didEndHighlighting()
			}
		}
	}

	public static var currentlyHighlightedNode:CXHighlightingNode? {
		willSet { currentlyHighlightedNode?.isHighlighted = false }
		didSet { currentlyHighlightedNode?.isHighlighted = true }
	}
	
	final public weak var leftHighlight:CXHighlightingNode?
	final public weak var rightHighlight:CXHighlightingNode?
	final public weak var upHighlight:CXHighlightingNode?
	final public weak var downHighlight:CXHighlightingNode?
	
}
