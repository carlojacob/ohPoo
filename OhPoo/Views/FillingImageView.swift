//
//  FillingImageView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 2/12/24.
//

import SwiftUI

struct FillingImageView: View {
	let timerScreenEmojiFont: Font = .custom("timerScreenEmoji", size: 250)
	let timerDuration: Int
	let secondsRemaining: Int
	let theme = PooTheme()
	
    var body: some View {
		Text("💩")
			.font(timerScreenEmojiFont)
			.overlay(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
				FillingView(endTime: timerDuration, remainingTime: secondsRemaining)
					.foregroundColor(theme.lightColor)
			}
			.overlay {
				RoundedRectangle(cornerRadius: 40)
					.stroke(theme.color, lineWidth: 10)
			}
    }
}

struct FillingImageView_Preview: PreviewProvider {
	static var theme = PooTheme()
	
	static var previews: some View {
		FillingImageView(timerDuration: 180, secondsRemaining: 100)
			.background(Color(theme.lightColor))
	}
}
