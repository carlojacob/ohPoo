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
			Link("Privacy Policy", destination: URL(string: "https://docs.google.com/document/d/e/2PACX-1vREizHXLyevX6s9bW4261AlwuaoOO2dHk3MjddNHzlJ9pLhX1s_Fj3oMju6DFR1A3nfyGeibqdc9_xz/pub")!)
		}
		.foregroundStyle(pooTimer.theme.color)
	}
}

#Preview {
	SettingsView().environmentObject(PooTimer())
}
