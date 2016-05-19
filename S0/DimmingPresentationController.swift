//
//  DimmingPresentationController.swift
//  StoreSearch
//
//  Created by 文川术 on 15/8/13.
//  Copyright (c) 2015年 xiaoyao. All rights reserved.
//

import UIKit

class DimmingPresentationController: UIPresentationController {

//	lazy var dimmingView = UIView()

	override func presentationTransitionWillBegin() {
		super.presentationTransitionWillBegin()
//		dimmingView.frame = containerView!.bounds
//		dimmingView.backgroundColor = UIColor.whiteColor()
//		containerView!.insertSubview(dimmingView, atIndex: 0)
//
//		dimmingView.alpha = 0
//
//		if let transitionCoordinator = presentedViewController.transitionCoordinator() {
//
//			transitionCoordinator.animateAlongsideTransition({ (_) -> Void in
//				self.dimmingView.alpha = 1
//			}, completion: nil)
//		}
	}

	override func dismissalTransitionWillBegin() {
		super.dismissalTransitionWillBegin()

//		if let transitionCoordinator = presentedViewController.transitionCoordinator() {
//			transitionCoordinator.animateAlongsideTransition({ (_) -> Void in
//				self.dimmingView.alpha = 0
//			}, completion: nil)
//		}
	}
	
	override func shouldRemovePresentersView() -> Bool {
		return false
	}
}
