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
	let localNotifications = LocalNotifications()
	
	@StateObject var pooTimer = PooTimer()
	
	@Environment(\.scenePhase) private var scenePhase
	
	var body: some View {
		VStack {
			Spacer()
			FillingImageView(timerDuration: pooTimer.timerDuration, secondsRemaining: pooTimer.secondsRemaining)
			Spacer()
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
			Spacer()
		}
		.padding()
		.onAppear {
			startPoo()
		}
		.onDisappear {
			stopPoo()
		}
		.background(Color(theme.lightColor))
		// When inactive, the flush sound plays, even with Silent mode on.
		// When we go to background phase the flush sound doesn't play,
		// so we set up a local notification to tell the user.
		.onChange(of: scenePhase, initial: false) { oldState, newState in
			let toBackground = newState == .background
			if pooTimer.secondsRemaining > 0 {
				if toBackground {
					// Remove existing notifications before setting up a new one.
					localNotifications.removePendingLocalNotifications()
					localNotifications.scheduleLocalNotification(secondsRemaining: pooTimer.secondsRemaining)
					print("Removed old pending notifs and scheduled a new one after moving from \(oldState) to \(newState): at \(Date())") // TODO: Remove
				}
			}
		}
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
