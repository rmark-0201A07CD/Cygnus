//
//  CXAppDelegate.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import Cocoa

public class CXAppDelegate: NSObject, NSApplicationDelegate {
	
/// OVERRIDE
	public var initialSceneClass:CXScene.Type { return CXScene.self }

///App Delegate
	@IBOutlet public weak var window:NSWindow?
	public func applicationDidFinishLaunching(aNotification: NSNotification) {
		let storyBoard = NSStoryboard(name: "Main", bundle: NSBundle(identifier: "com.markwick.Cygnus-OSX"))
		let vc = storyBoard.instantiateInitialController() as? NSViewController
		vc?.view.frame.size = window?.frame.size ?? CGSize()
		window?.contentViewController = vc
		window?.contentView = vc?.view
	}
	
	public func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
		return true
	}
}
