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
	@State private var homeScreenSoundOnValue: Bool = false
	@State private var isSettingsDisplayed: Bool = false
	@State private var saveButtonPressed: Bool = false
	
	private struct InitialEditingSettings {
		var timerDuration: Double
		var soundOn: Bool
	}
		
	@State private var initialEditingSettings: InitialEditingSettings = InitialEditingSettings(timerDuration: 0.0, soundOn: false)
	
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
					HStack {
						Text("\(homeScreenTimeValue) minutes")
						Image(systemName: homeScreenSoundOnValue ? "speaker.wave.3" : "speaker.slash")
					}
					.foregroundStyle(pooTimer.theme.color)
					.fontWeight(.semibold)
				}
				.toolbar {
					Button(action: {
						isSettingsDisplayed = true
						initialEditingSettings.timerDuration = pooTimer.timerDurationInMinutesAsDouble
						initialEditingSettings.soundOn = pooTimer.timerSoundOn
					}) {
						Image(systemName: "gearshape")
							.fontWeight(.bold)
					}
				}
				.sheet(isPresented: $isSettingsDisplayed, onDismiss: {
					if saveButtonPressed {
						saveButtonPressed = false
					} else {
						pooTimer.timerDurationInMinutesAsDouble = initialEditingSettings.timerDuration
						pooTimer.timerSoundOn = initialEditingSettings.soundOn
					}
				}) {
					NavigationStack {
						SettingsView()
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
										homeScreenSoundOnValue = pooTimer.timerSoundOn
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
