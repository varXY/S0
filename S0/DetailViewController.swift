//
//  DetailViewController.swift
//  S0
//
//  Created by 文川术 on 5/19/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

	var pointerView: PointerView!
	var xyScrollView: XYScrollView!

	var initTopDetailIndex: (Int, Int)!

	override func prefersStatusBarHidden() -> Bool {
		return true
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		pointerView = PointerView()
		view = pointerView

		xyScrollView = XYScrollView()
		xyScrollView.initTopDetailIndex = (1, 1)
		xyScrollView.XYDelegate = self
		xyScrollView.initTopDetailIndex = initTopDetailIndex
		view.addSubview(xyScrollView)
	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)
	}
}

extension DetailViewController: XYScrollViewDelegate {

	func xyScrollViewDidBeginScroll(begin: Bool, type: XYScrollType) {
		pointerView.makeOneVisible(begin, type: type)
	}

	func scrollTypeDidChange(type: XYScrollType) {
		pointerView.showPointer(type)
	}

	func xyScrollViewWillScroll(scrollType: XYScrollType, topViewIndex: Int) {
		if scrollType != .NotScrollYet {
			pointerView.pointers[scrollType.rawValue].alpha = 0.0
			pointerView.UDLR_labels[scrollType.rawValue].alpha = 0.0
		}
	}

	func xyScrollViewDidScroll(scrollType: XYScrollType, topViewIndex: Int) {
		switch scrollType {
		case .Left:
			navigationController?.popViewControllerAnimated(true)
		case .Right:
			break
		default:
			break
		}
	}
}
