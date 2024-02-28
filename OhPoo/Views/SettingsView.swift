//
//  SettingsView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI

struct SettingsView: View {
	@EnvironmentObject var pooTimer: PooTimer
	
	private var timerDurationInMinutes: Int {
		Int(pooTimer.timerDurationInMinutesAsDouble)
	}
	
	var body: some View {
		VStack {
			List {
				Section("Timer Duration") {
					HStack {
						Slider(value: $pooTimer.timerDurationInMinutesAsDouble, in: 3...30, step: 1) {
							Text("Time")
						}
						Spacer()
						Text("\(timerDurationInMinutes) minutes")
					}
				}
				Section("Timer Sounds") {
					Toggle("Sounds \(pooTimer.pooTimerSettings.timerSoundOn ? "on" : "off")", isOn: $pooTimer.pooTimerSettings.timerSoundOn)
				}
			}
			.fontWeight(.semibold)
			.foregroundStyle(pooTimer.theme.color)
		}
	}
}

#Preview {
	SettingsView().environmentObject(PooTimer())
}
