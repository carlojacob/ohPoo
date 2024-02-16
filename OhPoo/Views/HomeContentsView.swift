//
//  HomeContentsView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 2/16/24.
//

import SwiftUI

struct HomeContentsView: View {
	let homeScreenEmojiFont: Font = .custom("homeScreenEmoji", size: 250)
	let homeScreenValues: HomeScreenValues
	
	@EnvironmentObject var pooTimer: PooTimer
	
    var body: some View {
		Spacer()
		Text("💩")
			.font(homeScreenEmojiFont)
		Spacer()
		VStack {
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
		Spacer()
    }
}

#Preview() {
	HomeContentsView(homeScreenValues: HomeScreenValues())
		.environmentObject(PooTimer())
}
