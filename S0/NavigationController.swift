//
//  NavigationViewController.swift
//  S0
//
//  Created by 文川术 on 5/20/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBar.barTintColor = UIColor.backgroundBlack()
		navigationBar.titleTextAttributes = [
			NSForegroundColorAttributeName: UIColor.commentGreen(),
			NSFontAttributeName: UIFont.defaultFont(17)
		]
		navigationBar.tintColor = UIColor.whiteColor()
//		navigationBar.translucent = false
	}

}
