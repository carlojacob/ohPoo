//
//  CountdownView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI
import AVFoundation

struct CountdownView: View {
	@EnvironmentObject var pooTimer: PooTimer
	
	var body: some View {
		Text(pooTimer.timerText)
			.font(.custom("fullscreen", size: 90))
			.foregroundStyle(pooTimer.theme.color)
			.monospaced()
	}
}

#Preview {
	CountdownView().environmentObject(PooTimer())
}
