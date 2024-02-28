//
//  PooTimerContentsView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 2/16/24.
//

import SwiftUI

struct PooTimerContentsView: View {
	@EnvironmentObject var pooTimer: PooTimer
	
    var body: some View {
		Spacer()
		FillingImageView()
		Spacer()
		ZStack {
			Circle()
				.strokeBorder(lineWidth: 30)
				.foregroundStyle(pooTimer.theme.color)
				.overlay {
					Circle()
						.strokeBorder(lineWidth: 18)
						.foregroundStyle(Color.white)
						.padding(6)
				}
				.overlay {
					TimerArc(endTime: pooTimer.pooTimerSettings.timerDuration, currentTime: pooTimer.secondsRemaining)
						.rotation(Angle(degrees: -90))
						.stroke(pooTimer.theme.color, lineWidth: 15)
				}
			CountdownView()
		}
		Spacer()
    }
}

#Preview {
	PooTimerContentsView().environmentObject(PooTimer())
}
