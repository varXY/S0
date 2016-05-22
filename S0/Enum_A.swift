//
//  Struct_A.swift
//  S0
//
//  Created by 文川术 on 5/22/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

enum C_A: String {
	case application, additional, animate, ambient, active, action, attribute

	var detail: [String] {
		switch self {
		case .application:
			return [
				"application",
				"1. 应用程序\n2. 应用，运用，使用，用于\n3. 申请，请求",
				"func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool\n\nlet notificationEnabled = UIApplication.sharedApplication().currentUserNotificationSettings()!.types != UIUserNotificationType.None"
			]
		default:
			return ["", "", ""]
		}
	}
}