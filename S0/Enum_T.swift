//
//  Enum_T.swift
//  S0
//
//  Created by 文川术 on 5/22/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

enum T: String {
	case title, terminate, template, tableView, tintColor, translucent

	var detail: [String] {
		return ["Test", "1. meaning\n2. somemeaning\n3. this is not bad", "func viewDidLoad(animated: Bool)"]
	}
}