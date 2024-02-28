//
//  OhPooApp.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI

@main
struct OhPooApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	@StateObject var pooTimer = PooTimer()
	@StateObject var pooSettingsStore = PooSettingsStore()
	
    var body: some Scene {
        WindowGroup {
			HomeView(
				saveSettingsToSystemAction: { settingsToSave in
					Task {
						do {
							try await pooSettingsStore.save(pooTimerSettings: settingsToSave)
						} catch {
							fatalError(error.localizedDescription)
						}
					}
				},
				pooTimerSettings: $pooSettingsStore.pooTimerSettings
			)
			.environmentObject(pooTimer)
			.task {
				do {
					try await pooSettingsStore.load()
					pooTimer.pooTimerSettings.timerDuration = pooSettingsStore.pooTimerSettings.timerDuration
					pooTimer.pooTimerSettings.timerSoundOn = pooSettingsStore.pooTimerSettings.timerSoundOn
				} catch {
					fatalError(error.localizedDescription)
				}
			}
        }
    }
}
