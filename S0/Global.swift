//
//  Global.swift
//  S0
//
//  Created by 文川术 on 5/19/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation
import UIKit

// 屏幕尺寸信息
let ScreenBounds = UIScreen.mainScreen().bounds
let ScreenWidth = ScreenBounds.width
let ScreenHeight = ScreenBounds.height
let StatusBarHeight = UIApplication.sharedApplication().statusBarFrame.height

let smallBlockHeight: CGFloat = 50
let TriggerDistance: CGFloat = 50

let globalRadius: CGFloat = ScreenHeight * 0.007

let ABC_XYZ = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

// 延迟执行
func delay(seconds seconds: Double, completion: () -> ()) {
	let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))

	dispatch_after(popTime, dispatch_get_main_queue()) {
		completion()
	}

}