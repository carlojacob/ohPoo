//
//  HomeView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI

struct HomeScreenValues {
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
	let localNotifications = LocalNotifications()
	let saveSettingsToSystemAction: (_ pooTimerSettings: PooTimerSettings) -> Void
	
	@Environment(\.scenePhase) private var scenePhase
	
	@EnvironmentObject var pooTimer: PooTimer
	@Binding var pooTimerSettings: PooTimerSettings
	
	@State private var isSettingsDisplayed: Bool = false
	@State private var saveButtonPressed: Bool = false
	
	@State private var homeScreenValues: HomeScreenValues = HomeScreenValues()
	@State private var tempSettingsValues: TempSettingsValues = TempSettingsValues()
	
	var body: some View {
		NavigationStack {
			ZStack {
				Color(pooTimer.theme.lightColor)
					.ignoresSafeArea()
				DynamicOrientationStackView(content: HomeContentsView(homeScreenValues: homeScreenValues))
					.toolbar {
						Button(action: {
							onSettingsButtonTapped()
						}) {
							Image(systemName: "gearshape")
								.fontWeight(.bold)
						}
					}
					.sheet(isPresented: $isSettingsDisplayed, onDismiss: {
						onDismissSettings()
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
											onSaveSettingsButtonTapped()
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
		.onChange(of: pooTimerSettings) {
			homeScreenValues.timeInMinutes = pooTimerSettings.timerDuration / 60
			homeScreenValues.soundOn = pooTimerSettings.timerSoundOn
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
	
	private func onSettingsButtonTapped() {
		isSettingsDisplayed = true
		tempSettingsValues.timerDurationInMinutesAsDouble = pooTimer.timerDurationInMinutesAsDouble
		tempSettingsValues.timerSoundOn = pooTimer.pooTimerSettings.timerSoundOn
	}
	
	private func onDismissSettings() {
		if saveButtonPressed {
			saveButtonPressed = false
		} else {
			pooTimer.timerDurationInMinutesAsDouble = tempSettingsValues.timerDurationInMinutesAsDouble
			pooTimer.pooTimerSettings.timerSoundOn = tempSettingsValues.timerSoundOn
		}
	}
	
	private func onSaveSettingsButtonTapped() {
		isSettingsDisplayed = false
		saveButtonPressed = true
		homeScreenValues.timeInMinutes = Int(pooTimer.timerDurationInMinutesAsDouble)
		homeScreenValues.soundOn = pooTimer.pooTimerSettings.timerSoundOn
		let settingsToSave = PooTimerSettings(timerDuration: pooTimer.pooTimerSettings.timerDuration, timerSoundOn: pooTimer.pooTimerSettings.timerSoundOn)
		saveSettingsToSystemAction(settingsToSave)
	}
}

#Preview {
	HomeView(
		saveSettingsToSystemAction: { pooTimerSettings in },
		pooTimerSettings: .constant(PooTimerSettings.defaultData)
	)
	.environmentObject(PooTimer())
}
