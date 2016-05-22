//
//  Enum_B.swift
//  S0
//
//  Created by 文川术 on 5/22/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

enum B: String {
	case bundle, bool, bounds, background, behavior, CG

	var detail: [String] {
		switch self {
		case .bundle:
			return [
				"nihao"
			]
		default:
			return ["", "", ""]
		}
	}
}