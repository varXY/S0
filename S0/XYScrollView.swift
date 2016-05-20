//
//  XYScrollView.swift
//  D4
//
//  Created by 文川术 on 4/3/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit
import AVFoundation

@objc enum XYScrollType: Int {
	case Up, Down, Left, Right, NotScrollYet
}

@objc protocol XYScrollViewDelegate: class {
	func xyScrollViewDidBeginScroll(begin: Bool, type: XYScrollType)
	func xyScrollViewDidScroll(scrollType: XYScrollType, topViewIndex: Int)
	optional func xyScrollViewWillScroll(scrollType: XYScrollType, topViewIndex: Int)
	optional func writeViewWillInputText(index: Int, oldText: String, colorCode: Int)
	optional func didSelectedStory(storyIndex: Int)
	func scrollTypeDidChange(type: XYScrollType)
}

class XYScrollView: UIScrollView {

	var X0_contentView: UIScrollView!
	var X1_contentView: UIScrollView!
	var X2_contentView: UIScrollView!

	var Y0_storyView: DetailView!
	var Y1_storyView: DetailView!
	var Y2_storyView: DetailView!

	var topView: UIScrollView!
	var middleView: UIScrollView!
	var bottomView: UIScrollView!

	let topOrigin = CGPoint(x: 0, y: -ScreenHeight)
	let middleOrigin = CGPoint(x: 0, y: 0)
	let bottomOrigin = CGPoint(x: 0, y: ScreenHeight)

	var initTopDetailIndex: (Int, Int)! {
		didSet {
			if initTopDetailIndex != (0, 0) {
				let storyView_0 = DetailView(detail: [[String]]())
				storyView_0.tag = 110
				X0_contentView.addSubview(storyView_0)
			} else {
				let storyView_0 = DetailView(detail: [[String]]())
				storyView_0.tag = 110
				X0_contentView.addSubview(storyView_0)
			}

			let storyView_1 = DetailView(detail: [[String]]())
			storyView_1.tag = 110
			X1_contentView.addSubview(storyView_1)

			if initTopDetailIndex != (25, 100) {
				let storyView_2 = DetailView(detail: [[String]]())
				storyView_2.tag = 110
				X2_contentView.addSubview(storyView_2)
			} else {
				let storyView_2 = DetailView(detail: [[String]]())
				storyView_2.tag = 110
				X2_contentView.addSubview(storyView_2)
			}

			topDetailIndex = initTopDetailIndex
		}
	}

	var topDetailIndex = (0, 0)

	var beginScroll = false

	var inMainVC = false
	var doneReorder = true
	var topViewIndex = 1

	var scrolledType: XYScrollType = .NotScrollYet {
		didSet {
			XYDelegate?.scrollTypeDidChange(scrolledType)
		}
	}

	weak var XYDelegate: XYScrollViewDelegate?

	var animateTime: Double = 0.4

	init() {
		super.init(frame: ScreenBounds)
		backgroundColor = UIColor.clearColor()
		contentSize = CGSize(width: frame.width, height: 0)
		alwaysBounceHorizontal = true
		commonSetUp(self)

		X0_contentView = UIScrollView(frame: bounds)
		X0_contentView.frame.origin.y = -ScreenHeight
		X0_contentView.contentSize = CGSize(width: 0, height: frame.height)
		X0_contentView.alwaysBounceVertical = true
		X0_contentView.alpha = 0.0
		commonSetUp(X0_contentView)

		X1_contentView = UIScrollView(frame: bounds)
		X1_contentView.contentSize = CGSize(width: 0, height: frame.height)
		X1_contentView.alwaysBounceVertical = true
		commonSetUp(X1_contentView)

		X2_contentView = UIScrollView(frame: bounds)
		X2_contentView.frame.origin.y = ScreenHeight
		X2_contentView.contentSize = CGSize(width: 0, height: frame.height)
		X2_contentView.alwaysBounceVertical = true
		X2_contentView.alpha = 0.0
		commonSetUp(X2_contentView)

		topView = X0_contentView
		middleView = X1_contentView
		bottomView = X2_contentView

		addSubview(X0_contentView)
		addSubview(X1_contentView)
		addSubview(X2_contentView)
	}

	func commonSetUp(scrollView: UIScrollView) {
		scrollView.layer.cornerRadius = globalRadius
		scrollView.clipsToBounds = true
		scrollView.exclusiveTouch = true
		scrollView.directionalLockEnabled = true
		scrollView.pagingEnabled = false
		scrollView.scrollsToTop = false
		scrollView.delegate = self
	}


	func moveContentViewToTop(scrollType: XYScrollType) {
		switch scrolledType {
		case .Up:
			if doneReorder {
				doneReorder = false

				topView.frame.origin = middleOrigin
				topView.transform = CGAffineTransformMakeScale(0.9, 0.9)
				topView.alpha = 1.0

				animate({
					self.topView.transform = CGAffineTransformIdentity
					self.middleView.frame.origin = self.bottomOrigin
					}, completion: {
						self.sendSubviewToBack(self.middleView)
						self.middleView.alpha = 0.0
						self.middleView.frame.origin = self.topOrigin

						self.reorderView()
				})
			}


		case .Down:
			if doneReorder {
				doneReorder = false

				bringSubviewToFront(bottomView)
				bottomView.alpha = 1.0

				animate({
					self.middleView.alpha = 0.4
					self.middleView.transform = CGAffineTransformMakeScale(0.9, 0.9)
					self.bottomView.frame.origin = self.middleOrigin
					}, completion: {
						self.middleView.transform = CGAffineTransformIdentity
						self.middleView.alpha = 0.0
						self.middleView.frame.origin = self.bottomOrigin

						self.reorderView()
				})
			}


		default:
			break
		}

	}

	func animate(animations: () -> (), completion: (() -> ())?) {
		UIView.performSystemAnimation(.Delete, onViews: [], options: [], animations: {
			animations()
			}) { (_) in
				completion!()
		}
	}

	func changeStoryForContentView(contentView: UIScrollView, storyIndex: (Int, Int)) {
	}

	func removePartOfStory(contentView: UIScrollView, labelIndex: Int) {
	}

	func reorderView() {
		let contentViews = [X0_contentView, X1_contentView, X2_contentView]
		for contentView in contentViews {
			if contentView.frame.origin == topOrigin { topView = contentView }
			if contentView.frame.origin == middleOrigin { middleView = contentView }
			if contentView.frame.origin == bottomOrigin { bottomView = contentView }
		}
		doneReorder = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}


extension XYScrollView: UIScrollViewDelegate {

	func scrollViewDidScroll(scrollView: UIScrollView) {
		if (scrollView.contentOffset.x != 0 || scrollView.contentOffset.y != 0) && !beginScroll {
			var type = XYScrollType.NotScrollYet
			if scrollView.contentOffset.x == 0 && scrollView.contentOffset.y < 0 { type = .Up }
			if scrollView.contentOffset.x == 0 && scrollView.contentOffset.y > 0 { type = .Down	}
			if scrollView.contentOffset.x < 0 && scrollView.contentOffset.y == 0 { type = .Left }
			if scrollView.contentOffset.x > 0 && scrollView.contentOffset.y == 0 { type = .Right }

			XYDelegate?.xyScrollViewDidBeginScroll(true, type: type)
			beginScroll = true
		} else if scrollView.contentOffset == CGPoint(x: 0, y: 0) {
			XYDelegate?.xyScrollViewDidBeginScroll(false, type: XYScrollType.NotScrollYet)
			beginScroll = false
		}

		if scrollView != self {
			if scrollView.contentOffset.y > TriggerDistance {
				if scrolledType != .Down { scrolledType = .Down }
			} else if scrollView.contentOffset.y < -TriggerDistance {
				if scrolledType != .Up { scrolledType = .Up }
			} else {
				if scrolledType != .NotScrollYet { scrolledType = .NotScrollYet }
			}
		} else {
			if scrollView.contentOffset.x < -TriggerDistance {
				if scrolledType != .Left { scrolledType = .Left }
			} else if scrollView.contentOffset.x > TriggerDistance {
				if scrolledType != .Right { scrolledType = .Right }
			} else {
				if scrolledType != .NotScrollYet { scrolledType = .NotScrollYet }
			}
		}

	}

	func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		XYDelegate?.xyScrollViewWillScroll?(scrolledType, topViewIndex: topViewIndex)
		moveContentViewToTop(scrolledType)
		XYDelegate?.xyScrollViewDidScroll(scrolledType, topViewIndex: topViewIndex)
		scrolledType = .NotScrollYet

	}

}







