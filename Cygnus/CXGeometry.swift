//
//  CXGeometry.swift
//  Cygnus
//
//  Created by Robbie Markwick on 7/31/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit

public func + (lhs:CGPoint,rhs:CGPoint)->CGPoint {
	return CGPoint(x: lhs.x+rhs.x, y: lhs.y+rhs.y)
}
public func - (lhs:CGPoint,rhs:CGPoint)->CGPoint {
	return CGPoint(x: lhs.x-rhs.x, y: lhs.y-rhs.y)
}

public func * (lhs:CGSize,rhs:CGFloat)->CGSize {
	return CGSize(width: lhs.width*rhs, height: lhs.height*rhs)
}
