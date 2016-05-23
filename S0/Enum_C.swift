//
//  Nnum_C.swift
//  S0
//
//  Created by 文川术 on 5/22/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

enum E_C: String {
	case component, category, cell, completion, context, controller, CG

	var detail: [String] {
		switch self {
		case .component:
			return [
				"nihao",
				""
			]
		default:
			return ["", "", ""]
		}
	}
}