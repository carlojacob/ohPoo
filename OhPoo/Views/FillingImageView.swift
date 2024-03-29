//
//  FillingImageView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 2/12/24.
//

import SwiftUI

struct FillingImageView: View {
	@EnvironmentObject var pooTimer: PooTimer
	
    var body: some View {
		Image("PooImage")
			.resizable()
			.scaledToFit()
			.overlay(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
				FillingView(endTime: pooTimer.pooTimerSettings.timerDuration, remainingTime: pooTimer.secondsRemaining)
					.foregroundColor(pooTimer.theme.lightColor)
			}
			.overlay {
				RoundedRectangle(cornerRadius: 40)
					.stroke(pooTimer.theme.color, lineWidth: 10)
			}
			.scaleEffect(CGSize(width: 0.9, height: 0.9))
    }
}

struct FillingImageView_Preview: PreviewProvider {
	static var theme = PooTheme()
	
	static var previews: some View {
		FillingImageView().environmentObject(PooTimer())
			.background(Color(theme.lightColor))
	}
}
