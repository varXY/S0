//
//  Words.swift
//  S0
//
//  Created by 文川术 on 5/19/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

enum Catalog: Int {
	case A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z

	var title: String {
		return "#" + String(self)
	}

	var words: [String] {
		switch self {
		case .A:
			return ["application", "additional", "animate", "ambient", "active", "action", "attribute"]
		case .B:
			return ["bundle", "bool", "bounds", "background", "behavior", "CG"]
		case .C:
			return ["component", "category", "cell", "completion", "context","controller"]
		case .D:
			return ["delegate", "dispatch", "delay", "double", "draw"]
		case .E:
			return ["enum", "extension"]
		case .F:
			return ["foundation", "frame", "false", "format", "formatter", "foreground"]
		case .G:
			return ["guard", "graphics"]
		case .H:
			return ["hide", "hierarchy"]
		case .I:
			return ["identifier", "item", "icon", "instance", "import"]
		case .J:
			return [""]
		case .K:
			return ["kit", "key", "", "", "", "", "", ""]
		case .L:
			return ["launch", "localize"]
		case .M:
			return ["model"]
		case .N:
			return ["navigation", "navigationBar", "NS", "nil"]
		case .O:
			return ["options"]
		case .P:
			return ["perform", "play", "prefer"]
		case .Q:
			return ["quit"]
		case .R:
			return ["responder", "rawValue", "return", "rect"]
		case .S:
			return ["shortcut", "string", "subtitle", "set", "session", "separate", "statusBar", "second"]
		case .T:
			return ["title", "terminate", "template", "tableView", "tintColor", "translucent"]
		case .U:
			return ["userInfo", "UI"]
		case .V:
			return ["viewController"]
		case .W:
			return ["where"]
		case .X:
			return [""]
		case .Y:
			return [""]
		case .Z:
			return [""]
		}
	}
}