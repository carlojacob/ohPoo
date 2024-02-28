//
//  PooTimerSettings.swift
//  OhPoo
//
//  Created by Carlo Jacob on 2/26/24.
//

import Foundation

struct PooTimerSettings: Codable, Equatable {
	var timerDuration: Int
	var timerSoundOn: Bool
	
	init(timerDuration: Int = 180, timerSoundOn: Bool = false) {
		self.timerDuration = timerDuration
		self.timerSoundOn = timerSoundOn
	}
}

extension PooTimerSettings {
	static let defaultData: PooTimerSettings = PooTimerSettings(timerDuration: 180, timerSoundOn: false)
}
