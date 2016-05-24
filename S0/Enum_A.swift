//
//  Struct_A.swift
//  S0
//
//  Created by 文川术 on 5/22/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

enum E_A: String {
	case application, additional, animate, ambient, active, action, attribute, as_S

	var detail: [String] {
		switch self {
		case .application:
			return [
				"1. 应用程序\n2. 应用；运用；使用；用于\n3. 申请；请求",
				"func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool\n\nlet notificationEnabled = UIApplication.sharedApplication().currentUserNotificationSettings()!.types != UIUserNotificationType.None\n\n// test\n// 2. test"
			]
		case .additional:
			return [
				"1. 附加的；额外的；外加的\n2. 另外的；追加的；添加的",
				"var additionalRecipients: [CSPerson]?\n\nvar HTTPAdditionalHeaders: [NSObject : AnyObject]?\n\nfunc additionalContentForURL(_ absoluteURL: NSURL) throws -> AnyObject"
			]
		case .animate:
			return [
				"1. 动画；活动的；有生气的\n2. 使具活力；使生气勃勃；把…制作成动画片",
				"func isAnimated() -> Bool\n\nnavigationController?.popViewControllerAnimated(true)\n\npublic func viewWillAppear(animated: Bool)"
			]
		case .ambient:
			return [
				"1. 周围环境的；周围的；产生轻松氛围的\n\n2. 氛围音乐；环境音乐；环境光",
				"try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)\n\npublic let AVAudioSessionCategorySoloAmbient: String"
			]
		case .active:
			return [
				"1. 活跃的；主动的；激活2. 忙碌的；积极的；定期进行的；起作用的",
			"var active: Bool\n\nfunc applicationDidBecomeActive(application: UIApplication)\n\npublic enum UIApplicationState : Int {\n    case Active\n    case Inactive\n    case Background\n}"
			]
		case .action:
			return [
				"1. 动作；操作；作用\n2. 行动；行为；",
				"self.view.userInteractionEnabled = true\n\nlet action = UIAlertAction(title: \"确定\", style: .Default, handler: nil)"
			]
		case .attribute:
			return [
				"1. 定语；特征；品质\n2. 属性；象征",
				"public let NSFontAttributeName: String\n\npublic let NSForegroundColorAttributeName: String\n\nnavigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]"
			]
		case .as_S:
		return [
		"1. 用于类型判断和转换\n2. as!用于强制转换，as?用于可为空转换",
		"let word = \"这是个String类型\"\nlet length = (word as NSString).length\n// 把String类型转换成NSString类型，获取其长度。\n\nlet text = word as! String\n// 强制转换类型，如果无法转换，程序会出错。\n\nguard let string = word as? String else { return }\n// 对word进行可选转换，如果无法转换，则跳过。"
			]
		}
	}
}