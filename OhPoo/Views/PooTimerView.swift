//
//  PooTimerView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI
import AVFoundation

struct PooTimerView: View {
	let localNotifications = LocalNotifications()
	
	@EnvironmentObject var pooTimer: PooTimer
	
	@Environment(\.scenePhase) private var scenePhase
	
	var body: some View {
		DynamicOrientationStackView(content: PooTimerContentsView())
			.padding()
			.onAppear {
				startPoo()
			}
			.onDisappear {
				stopPoo()
			}
			.background(Color(pooTimer.theme.lightColor))
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
		pooTimer.reset(timerDuration: pooTimer.timerDuration)
		pooTimer.startPoo()
	}
	
	@MainActor
	private func stopPoo() {
		pooTimer.stopPoo()
	}
}

#Preview {
	PooTimerView().environmentObject(PooTimer(timerDuration: 180))
}
