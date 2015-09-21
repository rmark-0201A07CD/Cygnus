//
//  CXScene.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit
import StoreKit

public class CXScene:SKScene{
	final public var presentingScene:CXScene?
	weak var viewController:CXViewController?
	
	final public var visible:Bool { return view != nil }
	
	private var didResize:Bool = false
	private var didFirstResize:Bool = false
	override public var size:CGSize {
		didSet {
			guard didFirstResize else { didFirstResize = true; return }
			didResize = true
		}
	}
	
	final public func showConfirmPurchaseLabel(product:SKProduct?, completion:(Bool)->()) {
		let numberFormatter = NSNumberFormatter()
		numberFormatter.numberStyle = .CurrencyStyle
		numberFormatter.locale = product?.priceLocale
		let price = numberFormatter.stringFromNumber(product?.price ?? 0) ?? "$0.00"
		let name = product?.localizedTitle ?? "Nothing"
		#if os(iOS)
			let askToBuy = UIAlertController(title: "Confirm Purchase", message: "Purchase \(name) for \(price)", preferredStyle: .Alert)
			askToBuy.addAction(UIAlertAction(title: "NO", style: .Cancel) { alertAction in
				completion(false)
			})
			askToBuy.addAction(UIAlertAction(title: "YES", style: .Default) { alertAction in
				completion(true)
			})
			viewController?.presentViewController(askToBuy, animated: true, completion: nil)
		#elseif os(OSX)
			let alert = NSAlert()
			alert.messageText = "Confirm Purchase"
			alert.informativeText = "Purchase \(name) for \(price)"
			alert.addButtonWithTitle("YES")
			alert.addButtonWithTitle("NO")
			completion( alert.runModal() == NSAlertFirstButtonReturn )
		#endif
	}
	
	final public func presentScene(scene:CXScene, transition:SKTransition = SKTransition.crossFadeWithDuration(0.5)){
		scene.presentingScene = self
		view?.presentScene(scene, transition:transition)
	}
	final public func dismissScene(transition:SKTransition = SKTransition.crossFadeWithDuration(0.5)){
		guard let scene = presentingScene else { return }
		if didResize { scene.size = size }
		view?.presentScene(scene, transition:transition)
	}
	
	final public func displayInterstialAd(){
		#if os(iOS)
			viewController?.showInterstialAd()
		#endif
	}
	
	#if os(tvOS)
	public var swipeToHighlightEnabled:Bool = false
	
	public func swipedRight(){ }
	public func swipedLeft(){ }
	public func swipedUp(){ }
	public func swipedDown(){ }
	
	#endif
}





























