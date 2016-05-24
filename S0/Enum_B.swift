//
//  Enum_B.swift
//  S0
//
//  Created by 文川术 on 5/22/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

enum E_B: String {
	case bundle, bool, bounds, background, behavior, break_S

	var detail: [String] {
		switch self {
		case .bundle:
			return [
				"1. 目录；路径\n2. 捆；束；包袱",
				"NSBundle.mainBundle().bundleIdentifier!\n\ncellNib = UINib(nibName: \"ImageCell\", bundle: nil)\n\nNSBundle.mainBundle().pathForResource(\"right\", ofType: \"caf\")!"
			]
		case .bool:
			return [
				"1. 布尔型；布尔值；布尔类型",
				"override func viewDidAppear(animated: Bool)\n\ntypealias completionHandler = (Bool) -> Void)\n\nlet right: Bool = true"
			]
		case .bounds:
			return [
				"1. 边界；界限；界线\n2. 限制范围；极限",
				"let screenBounds = UIScreen.mainScreen().bounds\n\nlet bounds = CGRect(x: 0, y: 0, width: 100, height: 100)\n\nfunc textRectForBounds(bounds: CGRect) -> CGRect"
			]
		case .background:
			return [
				"1. 后台；背景\n2. 底色；幕后；背景颜色",
				"view.backgroundColor = UIColor.whiteColor()\n\ncell.selectedBackgroundView = UIView()\n\npublic func setBackgroundImage(backgroundImage: UIImage?, forBarPosition barPosition: UIBarPosition, barMetrics: UIBarMetrics)"
			]
		case .behavior:
			return [
				"1. 举止；态度；行动\n2. 行为；性能；表现；(生物的)习性",
			"var priceFormatter: NSNumberFormatter = {\n    let pf = NSNumberFormatter()\n    pf.formatterBehavior = .Behavior10_4\n    pf.numberStyle = .CurrencyStyle\n    return pf\n}()"
			]
		case .break_S:
			return [
			"1. 在循环语句中，终止并跳出循环\n2. 终止switch语句的情况（case）",
			""
			]
		}
	}

}