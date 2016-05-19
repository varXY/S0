//
//  SildeOutAnimationController.swift
//  StoreSearch
//
//  Created by 文川术 on 15/8/15.
//  Copyright (c) 2015年 xiaoyao. All rights reserved.
//

import UIKit

class SlideOutAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 0.4
	}

	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

		if let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) {
			fromView.backgroundColor = UIColor.clearColor()

			UIView.performSystemAnimation(.Delete, onViews: [], options: [], animations: {
				fromView.alpha = 0.0
				fromView.frame.origin.x += ScreenWidth
				}, completion: { (finished) in
					transitionContext.completeTransition(finished)
			})

		}
	}
}
