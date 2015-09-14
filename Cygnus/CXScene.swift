//
//  CXScene.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit

public class CXScene:SKScene{
	final public var presentingScene:CXScene?
	weak var viewController:CXViewController?
	
	public func didAppear(){}
	public func didDisappear(){}
	final public var visible:Bool { return view != nil }
	
	final public func presentScene(scene:CXScene, transition:SKTransition = SKTransition.crossFadeWithDuration(0.5)){
		scene.presentingScene = self
		view?.presentScene(scene, transition:transition)
		scene.didAppear()
		didDisappear()
	}
	final public func dismissScene(transition:SKTransition = SKTransition.crossFadeWithDuration(0.5)){
		guard let scene = presentingScene else { return }
		view?.presentScene(scene, transition:transition)
		scene.didAppear()
		didDisappear()
	}
	
	final public func displayInterstialAd(){
		#if os(iOS)
			viewController?.showInterstialAd()
		#endif
	}
}







