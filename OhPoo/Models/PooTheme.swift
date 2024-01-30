//
//  PooTheme.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI

enum PooTheme {
	case pooColor
	
	var color: Color {
		return Color.poo
	}
	
	var lightColor: Color {
		return Color.pooLight
	}
	
	init() {
		self = .pooColor
	}
}
