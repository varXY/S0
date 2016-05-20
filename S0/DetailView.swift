//
//  DetailView.swift
//  S0
//
//  Created by 文川术 on 5/20/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import UIKit

class DetailView: UIView {

	init(detail: [[String]]) {
		super.init(frame: ScreenBounds)
		backgroundColor = UIColor.backgroundBlack()
		layer.cornerRadius = globalRadius
		clipsToBounds = true
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
