//
//  CXScene.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit

public class CXScene:SKScene{
	public var presentingScene:SKScene?
	weak var viewController:CXViewController?

	override required public init(size:CGSize){
		super.init(size: size)
	}
	
	public required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	public func presentScene(scene:CXScene, transition:SKTransition = SKTransition.crossFadeWithDuration(0.5)){
		scene.presentingScene = self
		view?.presentScene(scene, transition:transition)
	}
	public func dismissScene(transition:SKTransition = SKTransition.crossFadeWithDuration(0.5)){
		guard let scene = presentingScene else { return }
		view?.presentScene(scene, transition:transition)
	}
	
	public func displayInterstialAd(){
		#if os(iOS)
			viewController?.showInterstialAd()
		#endif
	}
}







