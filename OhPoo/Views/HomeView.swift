//
//  HomeView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI

private struct HomeScreenValues {
	var timeInMinutes: Int
	var soundOn: Bool
	
	init(timeInMinutes: Int = 3, soundOn: Bool = false) {
		self.timeInMinutes = timeInMinutes
		self.soundOn = soundOn
	}
}

private struct TempSettingsValues {
	var timerDurationInMinutesAsDouble: Double
	var timerSoundOn: Bool
	
	init(timerDurationInMinutesAsDouble: Double = 3.0, timerSoundOn: Bool = false) {
		self.timerDurationInMinutesAsDouble = timerDurationInMinutesAsDouble
		self.timerSoundOn = timerSoundOn
	}
}

struct HomeView: View {
	let homeScreenEmojiFont: Font = .custom("homeScreenEmoji", size: 250)
	let localNotifications = LocalNotifications()
	
	@Environment(\.scenePhase) private var scenePhase
	
	@EnvironmentObject var pooTimer: PooTimer
	
	@State private var isSettingsDisplayed: Bool = false
	@State private var saveButtonPressed: Bool = false
	
	@State private var homeScreenValues: HomeScreenValues = HomeScreenValues()
	@State private var tempSettingsValues: TempSettingsValues = TempSettingsValues()
	
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
					Label("\(homeScreenValues.timeInMinutes) minutes", systemImage: homeScreenValues.soundOn ? "speaker.wave.3" : "speaker.slash")
						.labelStyle(.trailingIcon)
						.foregroundStyle(pooTimer.theme.color)
						.fontWeight(.semibold)
				}
				.toolbar {
					Button(action: {
						isSettingsDisplayed = true
						tempSettingsValues.timerDurationInMinutesAsDouble = pooTimer.timerDurationInMinutesAsDouble
						tempSettingsValues.timerSoundOn = pooTimer.timerSoundOn
					}) {
						Image(systemName: "gearshape")
							.fontWeight(.bold)
					}
				}
				.sheet(isPresented: $isSettingsDisplayed, onDismiss: {
					if saveButtonPressed {
						saveButtonPressed = false
					} else {
						pooTimer.timerDurationInMinutesAsDouble = tempSettingsValues.timerDurationInMinutesAsDouble
						pooTimer.timerSoundOn = tempSettingsValues.timerSoundOn
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
										homeScreenValues.timeInMinutes = Int(pooTimer.timerDurationInMinutesAsDouble)
										homeScreenValues.soundOn = pooTimer.timerSoundOn
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
