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