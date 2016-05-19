//
//  FadeOutAnimationController.swift
//  StoreSearch
//
//  Created by 文川术 on 15/8/16.
//  Copyright (c) 2015年 xiaoyao. All rights reserved.
//

import UIKit

class FadeOutAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 0.4
	}

	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		if let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) {
			let duration = transitionDuration(transitionContext)

			UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: [], animations: {
				fromView.alpha = 0
			}, completion: { (finished) -> Void in
				transitionContext.completeTransition(finished)
			})
		}
	}
}
