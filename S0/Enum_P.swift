//
//  Enum_P.swift
//  S0
//
//  Created by 文川术 on 5/22/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

enum E_P: String {
	case perform, play, prefer

	var detail: [String] {
		return ["Test", "1. meaning\n2. somemeaning\n3. this is not bad", "func viewDidLoad(animated: Bool)"]
	}
}