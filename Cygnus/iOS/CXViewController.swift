//
//  CXViewController.swift
//  Cygnus
//
//  Created by Robbie Markwick on 9/2/15.
//  Copyright © 2015 Robbie Markwick. All rights reserved.
//

import SpriteKit
import UIKit
import iAd

class CXViewController: UIViewController, ADBannerViewDelegate {

	@IBOutlet var adBanner:ADBannerView?
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		let skView = view as? SKView
		skView?.multipleTouchEnabled = false

		guard let scene = (UIApplication.sharedApplication().delegate as? CXAppDelegate)?.initialScene(view.bounds.size) else { fatalError("CXAppDelegate Subclass Not Implemented") }
		
		scene.viewController = self
		skView?.presentScene(scene)
		scene.didAppear()
        // Set up Ads
		adBanner?.hidden = !CXAppDelegate().shouldShowAds
    }
	
	func showInterstialAd(){
		requestInterstitialAdPresentation()
	}
	
	func bannerViewDidLoadAd(banner: ADBannerView?) {
		UIView.animateWithDuration(0.3){
			banner?.alpha = 1.0
		}
	}
	func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
		UIView.animateWithDuration(0.3){
			banner?.alpha = 0.0
		}
	}
}