//
//  CrossPlatform.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit


#if os(iOS)
	public typealias CXColor = UIColor
#elseif os(OSX)
	public typealias CXColor = NSColor
#elseif os(tvOS)
	public typealias CXColor = UIColor
#endif

let almostClearColor = CXColor(white:0, alpha: 0.00001)