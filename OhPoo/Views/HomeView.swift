//
//  HomeView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI

struct HomeView: View {
	let fullScreenFont: Font = .custom("fullscreen", size: 250)
	let theme = PooTheme()
	
	@StateObject var pooTimer = PooTimer()
	
	@State private var isSettingsDisplayed: Bool = false
	@State private var initialEditingTimerDuration: Double = 0.0
	@State private var saveButtonPressed: Bool = false
	
	var body: some View {
		NavigationStack {
			ZStack {
				Color(theme.lightColor)
					.ignoresSafeArea()
				VStack {
					Text("💩")
						.font(fullScreenFont)
					NavigationLink {
						PooTimerView(timerDuration: pooTimer.timerDuration)
					} label: {
						Text("Start Timer")
							.padding()
							.background(theme.color)
							.foregroundStyle(Color.white)
							.font(.system(.title2, weight: .bold))
							.cornerRadius(15)
					}
					Text("\(pooTimer.timerDuration / 60) minutes")
						.foregroundStyle(theme.color)
						.fontWeight(.semibold)
				}
				.toolbar {
					Button(action: {
						isSettingsDisplayed = true
						initialEditingTimerDuration = pooTimer.timerDurationInMinutesAsDouble
					}) {
						Image(systemName: "gearshape")
							.foregroundColor(theme.color)
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
						SettingsView(isSettingsDisplayed: $isSettingsDisplayed, timerDurationInMinutesAsDouble: $pooTimer.timerDurationInMinutesAsDouble)
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
									}
								}
							})
					}
				}
			}
		}
	}
}

#Preview {
	HomeView()
}
