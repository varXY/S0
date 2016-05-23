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

	var contentViews = [UIScrollView]()

	let topOrigin = CGPoint(x: 0, y: -ScreenHeight)
	let middleOrigin = CGPoint(x: 0, y: 0)
	let bottomOrigin = CGPoint(x: 0, y: ScreenHeight)

	var topDetailIndex = (0, 0)

	var beginScroll = false

	var doneScroll = true
	var topViewIndex = 1

	var scrolledType: XYScrollType = .NotScrollYet {
		didSet {
			XYDelegate?.scrollTypeDidChange(scrolledType)
		}
	}

	weak var XYDelegate: XYScrollViewDelegate?

	var animateTime: Double = 0.4

	init(topDetailIndex: (Int, Int)) {
		super.init(frame: ScreenBounds)
		backgroundColor = UIColor.clearColor()
		contentSize = CGSize(width: frame.width, height: 0)
		alwaysBounceHorizontal = true
		commonSetUp(self)

		let origins_Y = [-ScreenHeight, 0, ScreenHeight]
		let details = [["", "", ""], Catalog(rawValue: topDetailIndex.0)!.detail(topDetailIndex.1), ["", "", ""]]

		contentViews = origins_Y.map({
			let contentView = UIScrollView(frame: bounds)
			contentView.frame.origin.y = $0
			contentView.contentSize = CGSize(width: 0, height: frame.height)
			commonSetUp(contentView)
			contentView.alwaysBounceVertical = true
//			contentView.alpha = 0.0

			contentView.addSubview(DetailView(detail: details[origins_Y.indexOf($0)!]))
			addSubview(contentView)
			return contentView
		})

		self.topDetailIndex = topDetailIndex

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

	func previousIndex() -> (Int, Int) {
		if topDetailIndex.1 == 0 {
			return topDetailIndex.0 != 0 ? (topDetailIndex.0 - 1, Catalog(rawValue: topDetailIndex.0 - 1)!.words.count - 1) : (25, Catalog(rawValue: 25)!.words.count - 1)
		} else {
			return (topDetailIndex.0, topDetailIndex.1 - 1)
		}
	}

	func nextIndex() -> (Int, Int) {
		if topDetailIndex.1 == (Catalog(rawValue: topDetailIndex.0)!.words.count - 1) {
			return topDetailIndex.0 != 25 ? (topDetailIndex.0 + 1, 0) : (0, 0)
		} else {
			return (topDetailIndex.0, topDetailIndex.1 + 1)
		}
	}


	func moveContentViewToTop(scrollType: XYScrollType) {
		switch scrolledType {
		case .Up:
			if doneScroll {
				doneScroll = false

				topDetailIndex = previousIndex()
				changeDetailForContentView(contentViews[0], index: topDetailIndex)

				contentViews[0].frame.origin = middleOrigin
				contentViews[0].transform = CGAffineTransformMakeScale(0.9, 0.9)
				contentViews[0].alpha = 1.0

				animate({
					self.contentViews[0].transform = CGAffineTransformIdentity
					self.contentViews[1].frame.origin = self.bottomOrigin
					}, completion: {
						self.sendSubviewToBack(self.contentViews[1])
						self.contentViews[1].alpha = 0.0
						self.contentViews[1].frame.origin = self.topOrigin

						self.contentViews = [self.contentViews[1], self.contentViews[0], self.contentViews[2]]
						self.doneScroll = true
				})
			}


		case .Down:
			if doneScroll {
				doneScroll = false

				topDetailIndex = nextIndex()
				changeDetailForContentView(contentViews[2], index: topDetailIndex)

				bringSubviewToFront(contentViews[2])
				contentViews[2].alpha = 1.0

				animate({
					self.contentViews[1].alpha = 0.4
					self.contentViews[1].transform = CGAffineTransformMakeScale(0.9, 0.9)
					self.contentViews[2].frame.origin = self.middleOrigin
					}, completion: {
						self.contentViews[1].transform = CGAffineTransformIdentity
						self.contentViews[1].alpha = 0.0
						self.contentViews[1].frame.origin = self.bottomOrigin

						self.contentViews = [self.contentViews[0], self.contentViews[2], self.contentViews[1]]
						self.doneScroll = true
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

	func changeDetailForContentView(contentView: UIScrollView, index: (Int, Int)) {
		if let detailView = contentView.subviews[0] as? DetailView {
//			detailView.backgroundColor = UIColor.redColor()
			detailView.reloadDetail(Catalog(rawValue: index.0)!.detail(index.1))
		}
	}

	func removePartOfStory(contentView: UIScrollView, labelIndex: Int) {
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







