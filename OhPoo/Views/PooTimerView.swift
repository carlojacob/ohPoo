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
	
	private var fartPlayer: AVPlayer { AVPlayer.getAudioPlayer(audioFilename: "fart-05") }
	
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
	
	@MainActor
	private func startPoo() {
		pooTimer.reset(timerDuration: timerDuration)
		pooTimer.startPoo()
		fartPlayer.seek(to: .zero)
		// MARK: Fart audio control
		// Commented to prevent noise each time you open this view
		// fartPlayer.play()
	}
	
	@MainActor
	private func stopPoo() {
		pooTimer.stopPoo()
	}
}

#Preview {
	PooTimerView(pooTimer: PooTimer(timerDuration: 180))
}
