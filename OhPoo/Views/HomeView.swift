//
//  HomeView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI

struct HomeView: View {
	let homeScreenEmojiFont: Font = .custom("homeScreenEmoji", size: 250)
	let localNotifications = LocalNotifications()
	
	@Environment(\.scenePhase) private var scenePhase
	
	@EnvironmentObject var pooTimer: PooTimer
	
	@State private var homeScreenTimeValue: Int = 3
	@State private var isSettingsDisplayed: Bool = false
	@State private var initialEditingTimerDuration: Double = 0.0
	@State private var saveButtonPressed: Bool = false
	
	var body: some View {
		NavigationStack {
			ZStack {
				Color(pooTimer.theme.lightColor)
					.ignoresSafeArea()
				VStack {
					Text("💩")
						.font(homeScreenEmojiFont)
					NavigationLink {
						PooTimerView()
					} label: {
						Text("Start Timer")
							.padding()
							.background(pooTimer.theme.color)
							.foregroundStyle(Color.white)
							.font(.system(.title2, weight: .bold))
							.cornerRadius(15)
					}
					Text("\(homeScreenTimeValue) minutes")
						.foregroundStyle(pooTimer.theme.color)
						.fontWeight(.semibold)
				}
				.toolbar {
					Button(action: {
						isSettingsDisplayed = true
						initialEditingTimerDuration = pooTimer.timerDurationInMinutesAsDouble
					}) {
						Image(systemName: "gearshape")
							.fontWeight(.bold)
					}
				}
				.sheet(isPresented: $isSettingsDisplayed, onDismiss: {
					if saveButtonPressed {
						saveButtonPressed = false
					} else {
						pooTimer.timerDurationInMinutesAsDouble = initialEditingTimerDuration
					}
				}) {
					NavigationStack {
						SettingsView(isSettingsDisplayed: $isSettingsDisplayed)
							.navigationTitle("Settings")
							.toolbar(content: {
								ToolbarItem(placement: .topBarLeading) {
									Button("Cancel") {
										isSettingsDisplayed = false
									}
								}
								ToolbarItem(placement: .topBarTrailing) {
									Button("Save") {
										isSettingsDisplayed = false
										saveButtonPressed = true
										homeScreenTimeValue = Int(pooTimer.timerDurationInMinutesAsDouble)
									}
								}
							})
							.fontWeight(.semibold)
					}
				}
			}
		}
		.tint(pooTimer.theme.color)
		.onAppear {
			// Request/check permission to send notifications.
			localNotifications.registerLocalNotification()
		}
		.onChange(of: scenePhase, initial: false) { _, newState in
			// Remove any pending notifications when we return to active.
			let toActive = newState == .active
			
			if toActive {
				localNotifications.removePendingLocalNotifications()
				print("Removed pending notifications: at \(Date())") // TODO: Remove
			}
		}
	}
}

#Preview {
	HomeView().environmentObject(PooTimer())
}
