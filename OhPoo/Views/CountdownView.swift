//
//  CountdownView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI
import AVFoundation

struct CountdownView: View {
	var timerText: String
	
	private var flushPlayer: AVPlayer { AVPlayer.getAudioPlayer(audioFilename: "toilet-flush-2") }
	
	var body: some View {
		Text(playFlushAtZero())
			.font(.custom("fullscreen", size: 90))
			.foregroundStyle(PooTheme.pooColor.color)
			.monospaced()
	}
	
	private func playFlushAtZero() -> String {
		if timerText == "0:00" {
			flushPlayer.seek(to: .zero)
			// MARK: Flush audio control
			// Commented to prevent noise each time you leave this (or its parent) view open
			// flushPlayer.play()
		}
		return timerText
	}
}

#Preview {
	CountdownView(timerText: "3:00")
}
