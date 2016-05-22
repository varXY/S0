//
//  DetailView.swift
//  S0
//
//  Created by 文川术 on 5/20/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

class DetailView: UIView {

	var titleLabel: UILabel!
	var meaningLabel: UILabel!
	var exampleLabel: UILabel!

	private let keywordAttributes = [NSForegroundColorAttributeName: UIColor.keywordPurple()]
	private let buildInAttributes = [NSForegroundColorAttributeName: UIColor.buildInBlue()]
	private let numberAttributes = [NSForegroundColorAttributeName: UIColor.numberPurple()]

	init(detail: [String]) {
		super.init(frame: ScreenBounds)
		backgroundColor = UIColor.backgroundBlack()
		layer.cornerRadius = globalRadius
		clipsToBounds = true

		titleLabel = UILabel(frame: CGRectMake(10, 0, ScreenWidth - 20, 60))
		titleLabel.text = detail[0]
		titleLabel.font = UIFont.defaultFont(20)
		titleLabel.textColor = UIColor.stringRed()
		addSubview(titleLabel)

		let upCommentLabel = UILabel(frame: CGRectMake(10, titleLabel.frame.height, ScreenWidth - 20, 40))
		upCommentLabel.text = "/*"
		upCommentLabel.font = UIFont.defaultFont(17)
		upCommentLabel.textColor = UIColor.commentGreen()
		addSubview(upCommentLabel)

		meaningLabel = UILabel(frame: CGRectMake(30, upCommentLabel.frame.origin.y + upCommentLabel.frame.height, ScreenWidth - 40, 80))
		meaningLabel.numberOfLines = 0
		meaningLabel.text = detail[1]
		meaningLabel.font = UIFont.defaultFont(17)
		meaningLabel.textColor = UIColor.commentGreen()
		meaningLabel.sizeToFit()
		addSubview(meaningLabel)

		let downCommentLabel = UILabel(frame: CGRectMake(10, meaningLabel.frame.origin.y + meaningLabel.frame.height, ScreenWidth - 20, 40))
		downCommentLabel.text = "*/"
		downCommentLabel.font = UIFont.defaultFont(17)
		downCommentLabel.textColor = UIColor.commentGreen()
		addSubview(downCommentLabel)

		let exampleCommentLabel = UILabel(frame: CGRectMake(10, downCommentLabel.frame.origin.y + downCommentLabel.frame.height, ScreenWidth - 20, 40))
		exampleCommentLabel.text = "// MARK: 示例"
		exampleCommentLabel.font = UIFont.defaultFont(17)
		exampleCommentLabel.textColor = UIColor.commentGreen()
		addSubview(exampleCommentLabel)

		exampleLabel = UILabel(frame: CGRectMake(30, exampleCommentLabel.frame.origin.y + exampleCommentLabel.frame.height + 10, ScreenWidth - 40, 80))
		exampleLabel.numberOfLines = 0
		exampleLabel.textColor = UIColor.plainWhite()
		exampleLabel.attributedText = stringToAttributedString(detail[2])
		exampleLabel.font = UIFont.defaultFont(17)
		exampleLabel.sizeToFit()
		addSubview(exampleLabel)
	}

	func stringToAttributedString(string: String) -> NSMutableAttributedString {
		let words = totalSepratedWords(string)
		let wordsIn_keywordPurple = filterKeywords(words)
		let wordsIn_buildInBlue = filterBuildInWords(words)

		print(wordsIn_keywordPurple)
		print(wordsIn_buildInBlue)

		let result = NSMutableAttributedString(string: string)

		wordsIn_keywordPurple.forEach({
			let range = result.mutableString.rangeOfString($0, options: .RegularExpressionSearch)
			result.addAttributes(keywordAttributes, range: range)
		})

		wordsIn_buildInBlue.forEach({
			var searchRange = NSMakeRange(0, result.mutableString.length)
			var foundRange = NSRange()

			repeat {
				searchRange.length = result.mutableString.length - searchRange.location
				foundRange = result.mutableString.rangeOfString($0, options: [], range: searchRange)
				if foundRange.location != NSNotFound {
					result.addAttributes(buildInAttributes, range: foundRange)
					searchRange.location = foundRange.location + foundRange.length
				} else {
					break
				}
			} while searchRange.location < result.mutableString.length
		})

		return result
	}

	func totalSepratedWords(string: String) -> [String] {
		let sentences = string.componentsSeparatedByString("\n\n")
		var words_a = [String]()
		sentences.forEach({
			let a = $0.componentsSeparatedByString(" ")
			words_a += a
		})

		return words_a
	}

	func filterKeywords(words: [String]) -> [String] {
		var keywords = [String]()
		words.forEach({ if Keywords.contains($0) { keywords.append($0) } })
		return keywords
	}

	func filterBuildInWords(words: [String]) -> [String] {
		var buildInWords = [String]()

		words.forEach({
			let dotWords = $0.componentsSeparatedByString(".")
			if dotWords.count > 1 {
				buildInWords += dotWords
			} else {
				let word = $0.removeMarks_1()
				if word.isUppercaseWord() { buildInWords.append(word) }
			}
		})

		buildInWords = buildInWords.map({ return $0.removeMarks_1() })
		return buildInWords
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
