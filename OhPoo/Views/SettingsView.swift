//
//  SettingsView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI

struct SettingsView: View {
	let theme = PooTheme()
	
	@Binding var isSettingsDisplayed: Bool
	@Binding var timerDurationInMinutesAsDouble: Double
	private var timerDurationInMinutes: Int {
		Int(timerDurationInMinutesAsDouble)
	}
	
	var body: some View {
		VStack {
			List {
				Section("Timer Duration") {
					HStack {
						Slider(value: $timerDurationInMinutesAsDouble, in: 3...30, step: 1) {
							Text("Time")
						}
						Spacer()
						Text("\(timerDurationInMinutes) minutes")
					}
				}
				.fontWeight(.semibold)
				.foregroundStyle(theme.color)
			}
		}
	}
}

struct SettingsView_Previews: PreviewProvider {
	static var lengthInMinutesAsDouble: Double = 3.0
	
	static var previews: some View {
		SettingsView(isSettingsDisplayed: .constant(true), timerDurationInMinutesAsDouble: .constant(lengthInMinutesAsDouble))
	}
}
