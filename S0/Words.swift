//
//  Words.swift
//  S0
//
//  Created by 文川术 on 5/19/16.
//  Copyright © 2016 xiaoyao. All rights reserved.
//

import Foundation

let Keywords = ["var ", "let ", "func ", "import ", "class ", "struct ", "enum ", "static ", "public ", "private ", "lazy ", "where ", "false ", "true ", "nil ", "guard ", "case ", "return ", "try ", "try! ", "#function", "#selector", "override ", "typealias ", "extension "]

enum Catalog: Int {
	case A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z

	var title: String {
		return "# " + String(self)
	}

	var words: [String] {
		switch self {
		case .A:
			return [
				"application", "additional", "animate", "ambient", "active", "action", "attribute"
			]
		case .B:
			return [
				"bundle", "bool", "bounds", "background", "behavior"
			]
		case .C:
			return [
				"component", "category", "cell", "completion", "context","controller", "CG"
			]
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
			return ["JSON"]
		case .K:
			return ["kit", "key"]
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
			return ["x"]
		case .Y:
			return ["y"]
		case .Z:
			return ["z"]
		}
	}

	func detail(wordIndex: Int) -> [String] {
		let word = words[wordIndex]
		let word_S = Keywords.contains(word + " ") ? word + "_S" : word

		switch self {
		case .A: return [word] + E_A(rawValue: word_S)!.detail
		case .B: return [word] + E_B(rawValue: word_S)!.detail
		case .C: return [word] + E_C(rawValue: word_S)!.detail
		case .D: return [word] + E_D(rawValue: word_S)!.detail
		case .E: return [word] + E_E(rawValue: word_S)!.detail
		case .F: return [word] + E_F(rawValue: word_S)!.detail
		case .G: return [word] + E_G(rawValue: word_S)!.detail
		case .H: return [word] + E_H(rawValue: word_S)!.detail
		case .I: return [word] + E_I(rawValue: word_S)!.detail
		case .J: return [word] + E_J(rawValue: word_S)!.detail
		case .K: return [word] + E_K(rawValue: word_S)!.detail
		case .L: return [word] + E_L(rawValue: word_S)!.detail
		case .M: return [word] + E_M(rawValue: word_S)!.detail
		case .N: return [word] + E_N(rawValue: word_S)!.detail
		case .O: return [word] + E_O(rawValue: word_S)!.detail
		case .P: return [word] + E_P(rawValue: word_S)!.detail
		case .Q: return [word] + E_Q(rawValue: word_S)!.detail
		case .R: return [word] + E_R(rawValue: word_S)!.detail
		case .S: return [word] + E_S(rawValue: word_S)!.detail
		case .T: return [word] + E_T(rawValue: word_S)!.detail
		case .U: return [word] + E_U(rawValue: word_S)!.detail
		case .V: return [word] + E_V(rawValue: word_S)!.detail
		case .W: return [word] + E_W(rawValue: word_S)!.detail
		case .X: return [word] + E_X(rawValue: word_S)!.detail
		case .Y: return [word] + E_Y(rawValue: word_S)!.detail
		case .Z: return [word] + E_Z(rawValue: word_S)!.detail
		}
	}
}