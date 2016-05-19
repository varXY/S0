//
//  DetailViewController.swift
//  S0
//
//  Created by 文川术 on 5/19/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

	var textView: UITextView!

	let titleAttributes = [
		NSForegroundColorAttributeName: UIColor.stringRed(),
		NSFontAttributeName: UIFont.boldSystemFontOfSize(20)
	]

	let definitionAttributes = [
		NSForegroundColorAttributeName: UIColor.commentGreen(),
		NSFontAttributeName: UIFont.boldSystemFontOfSize(18)
	]

	let exampleAttributes = [
		NSForegroundColorAttributeName: UIColor.numberPurple(),
		NSFontAttributeName: UIFont.boldSystemFontOfSize(18)
	]

	let commentAttributes = [
		NSForegroundColorAttributeName: UIColor.commentGreen(),
		NSFontAttributeName: UIFont.boldSystemFontOfSize(18)
	]

	let placeholder = NSMutableAttributedString(string: "", attributes: nil)

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.backgroundBlack()

		textView = UITextView(frame: view.bounds)
		view.addSubview(textView)

		let texts = ["range", "1. 范围，应用范围、部分\n2. 包括一定范围之间的各类事物", "let string = \"hello\".rangeOfString(\"he\")", "// Foundation/NSString"]

		let allAttributes = [titleAttributes, definitionAttributes, exampleAttributes, commentAttributes]

		let attributedTexts: [NSMutableAttributedString] = texts.map({
			let attributesText = NSMutableAttributedString(string: $0, attributes: allAttributes[texts.indexOf($0)!])
			return attributesText
		})


	}
}
