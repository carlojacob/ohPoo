//
//  CountdownView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI

struct CountdownView: View {
	var timerText: String
	
	var body: some View {
		Text(timerText)
			.font(.custom("fullscreen", size: 90))
			.foregroundStyle(Color.black)
			.monospaced()
	}
}

struct CountdownView_Previews: PreviewProvider {
	static var pooTimer = PooTimer()
	static var previews: some View {
		CountdownView(timerText: pooTimer.timerText)
	}
}
