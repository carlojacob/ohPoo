//
//  PooTimer.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import Foundation
import AVFoundation

@MainActor
class PooTimer: ObservableObject {
	@Published var secondsRemaining = 180
	@Published var timerText = "3:00"
	@Published var timerDuration: Int
	@Published var timerSoundOn: Bool
	
	var theme: PooTheme = PooTheme()
	
	private var timer: Timer?
	private var frequency: TimeInterval { 1.0 / 60.0 }
	private var timerStopped = false
	var timerDurationInMinutesAsDouble: Double {
		get {
			Double(timerDuration / 60)
		}
		set {
			timerDuration = Int(newValue * 60)
		}
	}
	private var timeElapsed: Int = 0
	private var timeRemaining: Int
	private var timeText: String {
		"\(String(timeRemaining/60)):\(String(format: "%02d", timeRemaining%60))"
	}
	private var startDate: Date?
	
	// Use to ensure that audio plays when it should.
	private var fartPlayed: Bool = false
	private var shouldPlayFart: Bool { timeRemaining == timerDuration && !fartPlayed && timerSoundOn }
	private var flushPlayed: Bool = false
	private var flushTimePassed: Bool = false
	private var shouldPlayFlush: Bool { timeRemaining == 0 && !flushPlayed && !flushTimePassed && timerSoundOn }
	
	init(timerDuration: Int = 180, timeRemaining: Int = 180, timerSoundOn: Bool = false) {
		self.timerDuration = timerDuration
		self.timeRemaining = timerDuration
		self.timerSoundOn = timerSoundOn
	}
	
	func startPoo() {
		timer = Timer.scheduledTimer(withTimeInterval: frequency, repeats: true) { [weak self] timer in
			self?.update()
		}
		timer?.tolerance = 0.1
		startDate = Date()
	}
	
	func stopPoo() {
		timer?.invalidate()
		timerStopped = true
	}
	
	nonisolated private func update() {

		Task { @MainActor in
			guard let startDate,
				  !timerStopped else { return }
			let secondsElapsed = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
			timeElapsed = secondsElapsed
			timeRemaining = max(timerDuration - timeElapsed, 0)
			flushTimePassed = timerDuration - timeElapsed < 0
			if shouldPlayFart {
				playFart()
				fartPlayed = true
			}
			if shouldPlayFlush {
				playFlush()
				flushPlayed = true
				timerStopped = true
			}
			self.secondsRemaining = timeRemaining
			timerText = timeText
		}
	}
	
	private func playFart() {
		var fartPlayer: AVPlayer { AVPlayer.getAudioPlayer(audioFilename: .fart) }
		fartPlayer.seek(to: .zero)
		fartPlayer.play()
	}
	
	private func playFlush() {
		var flushPlayer: AVPlayer { AVPlayer.getAudioPlayer(audioFilename: .flush) }
		flushPlayer.seek(to: .zero)
		flushPlayer.play()
	}
	
	func reset(timerDuration: Int) {
		self.timerDuration = timerDuration
		self.secondsRemaining = timerDuration
		self.timerDurationInMinutesAsDouble = Double(timerDuration / 60)
		self.timerStopped = false
		self.fartPlayed = false
		self.flushPlayed = false
		self.flushTimePassed = false
	}
}
