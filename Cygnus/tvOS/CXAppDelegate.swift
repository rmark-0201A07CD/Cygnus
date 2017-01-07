//
//  CXAppDelegate.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//
//

import UIKit

open class CXAppDelegate: UIResponder, UIApplicationDelegate {
	
/// OVERRIDE
	open func initialScene(size:CGSize)->CXScene { fatalError("CXAppDelegate Subclass Not Implemented") }

	
/// App Delegate
	public var window: UIWindow?
	@nonobjc public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		let storyBoard = UIStoryboard(name: "Main", bundle: Bundle(identifier: "com.markwick.Cygnus-tvOS"))
		window?.rootViewController = storyBoard.instantiateInitialViewController()
		window?.makeKeyAndVisible()
		
		
		
		return true
	}
}
