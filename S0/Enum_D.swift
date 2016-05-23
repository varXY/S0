//
//  Enum_D.swift
//  S0
//
//  Created by 文川术 on 5/22/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

enum E_D: String {
	case delegate, dispatch, delay, double, draw

	var detail: [String] {
		switch self {
		case .delegate:
			return [
				"nihao",
				""
			]
		default:
			return ["", "", ""]
		}
	}
}