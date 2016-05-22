//
//  String+.swift
//  S0
//
//  Created by 文川术 on 5/22/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation


extension String {

	func isUppercaseWord() -> Bool {
		if ABC_XYZ.contains(String(characters.prefix(1))) {
//			print(self)
			return true
		} else {
			return false
		}

	}

	func removeMarks_1() -> String {
		let marks = ["(", ")", "[", "]", "!", "?", ",", ".", ":"]
		var result = self

		for (index, chr) in result.characters.enumerate() {
			if marks.contains(String(chr)) {
				if index >= result.characters.count - 2 {
					result = String(result.characters.dropLast())
				} else {
					let range = Range<String.Index>(result.startIndex.advancedBy(index)..<result.startIndex.advancedBy(index + 1))
					result.replaceRange(range, with: "")
				}

			}
		}

		return result
	}

	func removeMarks() -> String {
		let marks = ["(", ")", "[", "]", "!", "?", ",", ".", ":"]
		var result = self

		for chr in characters {
			if marks.contains(String(chr)) {
				if let range = result.rangeOfString(String(chr)) {
					result.replaceRange(range, with: "")
				}
			}
		}

		return result
	}
}