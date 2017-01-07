//
//  CXScene.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit
import StoreKit

open class CXScene:SKScene{
	final public var presentingScene:CXScene?
	weak var viewController:CXViewController?
	
	final public var isVisible:Bool { return view != nil }
	
	private var didResize:Bool = false
	private var didFirstResize:Bool = false
	
	override open var size:CGSize {
		didSet {
			guard didFirstResize else { didFirstResize = true; return }
			didResize = true
		}
	}
	
	public final func showAlert(_ title:String, message:String, completion:@escaping ()->()){
		#if os(iOS)
			let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
				completion()
			}))
			viewController?.present(alert, animated: true, completion: nil)
		#elseif os(OSX)
			let alert = NSAlert()
			alert.messageText = title
			alert.informativeText = message
			_ = alert.addButton(withTitle: "OK")
			if alert.runModal() == NSAlertFirstButtonReturn {
				completion()
			}
		#elseif os(tvOS)
			let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
				completion()
			}))
			viewController?.present(alert, animated: true, completion: nil)
		#endif
	}
	
	final public func confirmPurchase(_ product:SKProduct?, completion:@escaping (Bool)->()) {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .currency
		numberFormatter.locale = product?.priceLocale
		let price = numberFormatter.string(from: product?.price ?? 0) ?? "$0.00"
		let name = product?.localizedTitle ?? "Nothing"
		#if os(iOS)
			print("Alert Requested")
			print("view Controller: \(viewController?.description)")
			let askToBuy = UIAlertController(title: "Confirm Purchase", message: "Purchase \(name) for \(price)", preferredStyle: .alert)
			askToBuy.addAction(UIAlertAction(title: "NO", style: .cancel) { alertAction in
				completion(false)
			})
			askToBuy.addAction(UIAlertAction(title: "YES", style: .default) { alertAction in
				completion(true)
			})
			viewController?.present(askToBuy, animated: true, completion: nil)
		#elseif os(OSX)
			let alert = NSAlert()
			alert.messageText = "Confirm Purchase"
			alert.informativeText = "Purchase \(name) for \(price)"
			alert.addButton(withTitle: "YES")
			alert.addButton(withTitle: "NO")
			completion( alert.runModal() == NSAlertFirstButtonReturn )
		#endif
	}
	
	final public func present(_ scene:CXScene, transition:SKTransition = SKTransition.crossFade(withDuration: 0.5)){
		scene.presentingScene = self
		scene.viewController = viewController
		view?.presentScene(scene, transition:transition)
	}
	final public func dismiss(_ transition:SKTransition = SKTransition.crossFade(withDuration: 0.5)){
		guard let scene = presentingScene else { return }
		if didResize { scene.size = size }
		view?.presentScene(scene, transition:transition)
	}
	
	open var isSwipeToHighlightEnabled:Bool = false
	
}

@available (tvOS 8.0,*)
public protocol CXSwipeResponder {
	func swipedLeft()
	func swipedRight()
	func swipedUp()
	func swipedDown()
}


























