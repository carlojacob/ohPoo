//
//  PooTimer.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import Foundation

@MainActor
class PooTimer: ObservableObject {
	let defaultDuration = 180
	@Published var secondsRemaining = 180
	@Published var timerText = ""
	@Published var timerDuration: Int
	
	private var timer: Timer?
	private var frequency: TimeInterval { 1.0 / 60.0 }
	private var timerStopped = false
	private var timerDurationInMinutes: Int { timerDuration / 60 }
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
	
	init(timerDuration: Int = 180, timeRemaining: Int = 180) {
		self.timerDuration = timerDuration
		self.timeRemaining = timerDuration
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
			self.secondsRemaining = timeRemaining
			timerText = timeText
		}
	}
	
	func reset(timerDuration: Int) {
		self.timerDuration = timerDuration
		secondsRemaining = timerDuration
		timerDurationInMinutesAsDouble = Double(timerDuration / 60)
	}
}
