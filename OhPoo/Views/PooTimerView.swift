//
//  PooTimerView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI

struct PooTimerView: View {
	var timerDuration: Int
	let theme = PooTheme()
	
	@StateObject var pooTimer = PooTimer()
	
	var body: some View {
		ZStack {
			Color(theme.lightColor)
				.ignoresSafeArea()
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
	}
	
	private func startPoo() {
		pooTimer.reset(timerDuration: timerDuration)
		pooTimer.startPoo()
	}
	
	private func stopPoo() {
		pooTimer.stopPoo()
	}
}

#Preview {
    PooTimerView(timerDuration: 180, pooTimer: PooTimer(timerDuration: 180))
}
