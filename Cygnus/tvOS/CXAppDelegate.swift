//
//  CXAppDelegate.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//
//

import UIKit

public class CXAppDelegate: UIResponder, UIApplicationDelegate {
	
/// OVERRIDE
	public func initialScene(size:CGSize)->CXScene { fatalError("CXAppDelegate Subclass Not Implemented") }

	
/// App Delegate
	public var window: UIWindow?
	public func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
		window = UIWindow(frame: UIScreen.mainScreen().bounds)
		let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle(identifier: "com.markwick.Cygnus-tvOS"))
		window?.rootViewController = storyBoard.instantiateInitialViewController()
		window?.makeKeyAndVisible()
		return true
	}
}
