//
//  PointerView.swift
//  D4
//
//  Created by 文川术 on 4/11/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

struct Pointer {
	let length: CGFloat = 30
	let textPointer = ["-", "+", "×", "="]

	let originCenters = [
		CGPointMake(ScreenWidth / 2, 30 / 2 - 30),
		CGPointMake(ScreenWidth / 2, ScreenHeight - (30 / 2) + 30),
		CGPointMake(30 / 2 - 30, ScreenHeight / 2),
		CGPointMake(ScreenWidth - (30 / 2) + 30, ScreenHeight / 2),
	]

	let toCenters = [
		CGPointMake(ScreenWidth / 2, 30 / 2 + 5),
		CGPointMake(ScreenWidth / 2, ScreenHeight - (30 / 2) - 6),
		CGPointMake(30 / 2 + 4.5, ScreenHeight / 2),
		CGPointMake(ScreenWidth - (30 / 2) - 4.5, ScreenHeight / 2),
	]

	func pointerLabel(type: XYScrollType) -> UILabel {
		let pointer = UILabel()
		pointer.frame.size = CGSize(width: length, height: length)
		pointer.center = originCenters[type.rawValue]
		pointer.textColor = UIColor.stringRed()
		pointer.text = textPointer[type.rawValue]
		pointer.textAlignment = .Center
		pointer.font = UIFont.defaultFont(19)
		return pointer
	}
}

class PointerView: UIView {

	var pointers = [UILabel]()
	var UDLR_labels = [UILabel]()
	var blankViews: [UIView]!

	var lastUpdateText: String! {
		didSet {
			self.UDLR_labels[0].text = lastUpdateText
		}
	}

	struct Label {
		let UD_size = CGSize(width: ScreenWidth - 30 * 2, height: 30)
		let LR_size = CGSize(width: 30, height: ScreenHeight - 30 * 4)
		let texts = ["前一个", "后一个", "返\n回", "浏\n览\n模\n式"]
		func label(type: XYScrollType) -> UILabel {
			let label = UILabel()
			label.backgroundColor = UIColor.clearColor()
			label.textAlignment = .Center
			label.textColor = UIColor.statementYellow()
			label.font = UIFont.defaultFont(15)
			label.text = texts[type.rawValue]

			switch type {
			case .Up:
				label.frame.origin = CGPoint(x: 30, y: 30)
				label.frame.size = UD_size
			case .Down:
				label.frame.origin = CGPoint(x: 30, y: ScreenHeight - 60)
				label.frame.size = UD_size
			case .Left:
				label.frame.origin = CGPoint(x: 30, y: 60)
				label.frame.size = LR_size
				label.numberOfLines = 0
			case .Right:
				label.frame.origin = CGPoint(x: ScreenWidth - 60, y: 60)
				label.frame.size = LR_size
				label.numberOfLines = 0
			default:
				break
			}

			return label
		}
	}

	let pointer = Pointer()

	init() {
		super.init(frame: ScreenBounds)
		backgroundColor = UIColor.backgroundBlack_light()
		layer.cornerRadius = globalRadius
		clipsToBounds = true
		tintColor = UIColor.whiteColor()

		let types = [XYScrollType.Up, XYScrollType.Down, XYScrollType.Left, XYScrollType.Right]
		pointers = types.map({ pointer.pointerLabel($0) })
		pointers.forEach({ $0.alpha = 0.0; addSubview($0) })

		UDLR_labels = types.map({ Label().label($0) })
		UDLR_labels.forEach({ $0.alpha = 0.0; addSubview($0) })

	}

	func showPointer(type: XYScrollType) {
		switch type {
		case .Up, .Down, .Left, .Right:
			move({ self.pointers[type.rawValue].center = self.pointer.toCenters[type.rawValue] })
		default:
			pointers.forEach({ (pointer) in
				pointer.alpha = 0.0
				let i = pointers.indexOf({ (imageView) -> Bool in
					return imageView == pointer
				})!
				if i < UDLR_labels.count { UDLR_labels[i].alpha = 0.0 }
			})

			delay(seconds: 0.4, completion: {
				self.pointers.forEach({ (pointer) in
					pointer.alpha = 1.0
					let i = self.pointers.indexOf({ (imageView) -> Bool in
						return imageView == pointer
					})!
					self.pointers[i].center = self.pointer.originCenters[i]
					if i < self.UDLR_labels.count { self.UDLR_labels[i].alpha = 1.0 }
				})
			})

		}
	}

	func move(animate: () -> ()) {
		UIView.performSystemAnimation(.Delete, onViews: [], options: [], animations: { 
			animate()
			}, completion: nil)
	}

	func makeOneVisible(show: Bool, type: XYScrollType) {
		if type != .NotScrollYet {
			pointers[type.rawValue].alpha = show ? 1.0 : 0.0
			UDLR_labels[type.rawValue].alpha = show ? 1.0 : 0.0
		} else if !show && type == .NotScrollYet {
			pointers.forEach({ $0.alpha = 0.0 })
			UDLR_labels.forEach({ $0.alpha = 0.0 })
		}
	}


	// MARK: - DetailViewController

	func showNoMore(top: Bool?) {
		if top == true {
			UDLR_labels[0].text = "没有了"
		} else if top == false {
			UDLR_labels[1].text = "没有了"
		} else {
			UDLR_labels[0].text = "前一个"
			UDLR_labels[1].text = "后一个"
		}
	}



	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}