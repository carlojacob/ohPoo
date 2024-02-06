//
//  CountdownView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI
import AVFoundation

struct CountdownView: View {
	var timerText: String
	
	var body: some View {
		Text(timerText)
			.font(.custom("fullscreen", size: 90))
			.foregroundStyle(PooTheme.pooColor.color)
			.monospaced()
	}
}

#Preview {
	CountdownView(timerText: "3:00")
}
