//
//  CXAppDelegate.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//
//

import UIKit
import iAd

open class CXAppDelegate: UIResponder, UIApplicationDelegate {
	
/// OVERRIDE
	open func initialScene(_ size:CGSize)->CXScene { fatalError("CXAppDelegate Subclass Not Implemented") }

	
/// App Delegate
	open var window: UIWindow?
	open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		let storyBoard = UIStoryboard(name: "Main", bundle: Bundle(identifier: "com.markwick.Cygnus-iOS"))
		window?.rootViewController = storyBoard.instantiateInitialViewController()
		window?.makeKeyAndVisible()
		return true
	}
}
