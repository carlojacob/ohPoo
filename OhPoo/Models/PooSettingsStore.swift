//
//  PooSettingsStore.swift
//  OhPoo
//
//  Created by Carlo Jacob on 2/26/24.
//

import SwiftUI

@MainActor
class PooSettingsStore: ObservableObject {
	@Published var pooTimerSettings: PooTimerSettings = PooTimerSettings()
	
	private static func fileURL() throws -> URL {
		try FileManager.default.url(for: .documentDirectory,
									in: .userDomainMask,
									appropriateFor: nil,
									create: false)
		.appendingPathComponent("pooTimerSettings.data")
	}
	
	func load() async throws {
		let task = Task<PooTimerSettings, Error> {
			let fileURL = try Self.fileURL()
			guard let data = try? Data(contentsOf: fileURL) else {
				return PooTimerSettings.defaultData
			}
			let timerSettings = try JSONDecoder().decode(PooTimerSettings.self, from: data)
			return timerSettings
		}
		let pooTimerSettings = try await task.value
		self.pooTimerSettings = pooTimerSettings
	}
	
	func save(pooTimerSettings: PooTimerSettings) async throws {
		let task = Task {
			let data = try JSONEncoder().encode(pooTimerSettings)
			let outfile = try Self.fileURL()
			try data.write(to: outfile)
		}
		_ = try await task.value
	}
}
