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
	private let stringAttributes = [NSForegroundColorAttributeName: UIColor.stringRed()]
	private let whiteAttributes = [NSForegroundColorAttributeName: UIColor.plainWhite()]
	private let commnetGreenAttribute = [NSForegroundColorAttributeName: UIColor.commentGreen()]

	init(detail: [String]) {
		super.init(frame: ScreenBounds)
		backgroundColor = UIColor.backgroundBlack()
		layer.cornerRadius = globalRadius
		clipsToBounds = true
		setupLabels(detail)
	}

	func reloadDetail(detail: [String]) {
		subviews.forEach({ $0.removeFromSuperview() })
		setupLabels(detail)
	}

	func setupLabels(detail: [String]) {
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


		let y = exampleCommentLabel.frame.origin.y + exampleCommentLabel.frame.height + 10

		exampleLabel = UILabel(frame: CGRectMake(0, 0, ScreenWidth * 10, ScreenHeight - y - 30))
		exampleLabel.numberOfLines = 0
		exampleLabel.textColor = UIColor.plainWhite()
		exampleLabel.attributedText = stringToAttributedString(detail[2])
		exampleLabel.font = UIFont.defaultFont(17)
		exampleLabel.sizeToFit()

		let scrollView = UIScrollView(frame: CGRectMake(10, y, ScreenWidth - 10, exampleLabel.frame.height + 10))
		scrollView.contentSize = CGSizeMake(exampleLabel.frame.width, 0)
		scrollView.addSubview(exampleLabel)

		addSubview(scrollView)
	}

	// MARK: Painting job

	func stringToAttributedString(string: String) -> NSMutableAttributedString {
		let step_0 = paintKeywordPurple(NSMutableAttributedString(string: string))
		let step_1 = paintBuildInBlue(step_0)
		let step_2 = paintNumberPurple(step_1)
		let step_3 = paintStringRed(step_2)
		let step_4 = paintWhite(step_3)
		let step_5 = paintCommentGreen(step_4)
		return step_5
	}

	func paintKeywordPurple(text: NSMutableAttributedString) -> NSMutableAttributedString {
		var ranges = [NSRange]()

		for keyword in Keywords {
			ranges += text.mutableString.rangesOfString(keyword)
		}

		let result = text
		for range in ranges {
			result.addAttributes(keywordAttributes, range: range)
		}

		return result
	}

	func paintBuildInBlue(text: NSMutableAttributedString) -> NSMutableAttributedString {
		var ranges = [NSRange]()

		for valueType in ValueTypes {
			ranges += text.mutableString.rangesOfString(valueType)
		}

		let result = text
		for range in ranges {
			result.addAttributes(buildInAttributes, range: range)
		}

		return result
	}

	func paintNumberPurple(text: NSMutableAttributedString) -> NSMutableAttributedString {
		
		var ranges = [NSRange]()

		for number in Numbers {
			ranges += text.mutableString.rangesOfString(String(number))
		}

		let result = text
		for range in ranges {
			result.addAttributes(numberAttributes, range: range)
		}

		return result
	}

	func paintStringRed(text: NSMutableAttributedString) -> NSMutableAttributedString {
		let ranges = text.mutableString.rangesOfString("\"")

		var stringRanges = [NSRange]()
		for i in 0.stride(to: ranges.count, by: 2) {
			if i != ranges.count - 1 && ranges.count != 1 {
				stringRanges += [NSRange(ranges[i].location...ranges[i + 1].location)]
			}
		}

		let result = text
		for range in stringRanges {
			result.addAttributes(stringAttributes, range: range)
		}

		return result
	}

	func paintWhite(text: NSMutableAttributedString) -> NSMutableAttributedString {
		let sentences = text.mutableString.componentsSeparatedByString("\n\n")
		var lines = [String]()
		var words = [String]()
		var whiteWords = [String]()

		for sentence in sentences {
			lines += sentence.componentsSeparatedByString("\n")
		}

		for line in lines {
			words += line.componentsSeparatedByString(" ")
		}

		words.forEach({
			let word = $0.removeMarks()
			if !Keywords.contains(word) && Int(word) == nil && !word.containsString("\"") && !ValueTypes.contains(word) {
				whiteWords.append($0.removeSelf())
			}
		})

		let result = text
		whiteWords.forEach({
			let range = result.mutableString.rangeOfString($0.checkBrackets())
			result.addAttributes(whiteAttributes, range: range)
		})

		return result
	}

	func paintCommentGreen(text: NSMutableAttributedString) -> NSMutableAttributedString {
		let sentences = text.mutableString.componentsSeparatedByString("\n\n")
		var lines = [String]()
		var words = [String]()
		var greenWords = [String]()

		for sentence in sentences {
			lines += sentence.componentsSeparatedByString("\n")
		}

		for line in lines {
			words += line.componentsSeparatedByString(" ")
		}

		for (index, word) in words.enumerate() {
			if word == "//" {
				var commnet = word + " " + words[index + 1]
				if words[index + 1].containsString(".") && index <= words.count - 3 {
					commnet += " " + words[index + 2]
				}
				greenWords.append(commnet)
			}
		}

		let result = text
		greenWords.forEach({
			let range = result.mutableString.rangeOfString($0)
			result.addAttributes(commnetGreenAttribute, range: range)
		})

		return result
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
