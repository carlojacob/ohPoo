//
//  PooTimerView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI
import AVFoundation

struct PooTimerView: View {
	var timerDuration: Int = 180
	let theme = PooTheme()
	
	@StateObject var pooTimer = PooTimer()
	
	var body: some View {
		ZStack {
			Circle()
				.strokeBorder(lineWidth: 30)
				.foregroundStyle(theme.color)
				.overlay {
					Circle()
						.strokeBorder(lineWidth: 18)
						.foregroundStyle(Color.white)
						.padding(6)
				}
				.overlay {
					TimerArc(endTime: pooTimer.timerDuration, currentTime: pooTimer.secondsRemaining)
						.rotation(Angle(degrees: -90))
						.stroke(theme.color, lineWidth: 15)
				}
			CountdownView(timerText: pooTimer.timerText)
		}
		.padding()
		.onAppear {
			startPoo()
		}
		.onDisappear {
			stopPoo()
		}
		.background(Color(theme.lightColor))
	}
	
	@MainActor
	private func startPoo() {
		pooTimer.reset(timerDuration: timerDuration)
		pooTimer.startPoo()
	}
	
	@MainActor
	private func stopPoo() {
		pooTimer.stopPoo()
	}
}

#Preview {
	PooTimerView(pooTimer: PooTimer(timerDuration: 180))
}
