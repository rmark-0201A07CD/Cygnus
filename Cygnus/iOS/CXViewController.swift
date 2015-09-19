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
	
	override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
		guard let scene = (self.view as? SKView)?.scene else { return }
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC)*coordinator.transitionDuration()/2))
		dispatch_after(time, dispatch_get_main_queue()){
			scene.size = size
		}
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