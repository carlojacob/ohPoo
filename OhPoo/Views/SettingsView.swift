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
				.fontWeight(.semibold)
				.foregroundStyle(pooTimer.theme.color)
			}
		}
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var lengthInMinutesAsDouble: Double = 3.0
	
	static var previews: some View {
		SettingsView().environmentObject(PooTimer())
	}
}
