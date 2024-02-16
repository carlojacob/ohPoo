//
//  LocalNotifications.swift
//  OhPoo
//
//  Created by Carlo Jacob on 2/7/24.
//

import Foundation
import UserNotifications

class LocalNotifications {
	func registerLocalNotification() {
		let center = UNUserNotificationCenter.current()
		
		center.requestAuthorization(options: [.alert, .badge, .sound]) { permissionGranted, error in
			if permissionGranted {
				print("Permission Granted at: \(Date())") // TODO: Update behavior
			} else {
				print("Permission NOT Granted at: \(Date())") // TODO: Update behavior
			}
		}
	}
	
	func scheduleLocalNotification(secondsRemaining: Int) {
		// Guardrail to ensure that secondsRemaining > 0
		guard secondsRemaining > 0 else { return }
		
		// Initialize notification center
		let center = UNUserNotificationCenter.current()
		
		// Setup custom sound for notification, or use default
		var sound: UNNotificationSound
		let flushSound: AudioFile = .flushShort
		let soundName = flushSound.filename
		let soundExtension = flushSound.fileExtension
		if let _ = Bundle.main.url(forResource: soundName, withExtension: soundExtension) {
			sound = UNNotificationSound(named: UNNotificationSoundName("\(soundName).\(soundExtension)"))
		} else { sound = UNNotificationSound.default }
		
		// Setup notification content
		let content = UNMutableNotificationContent()
		content.title = "Poo Timer Up!"
		content.body = "OK, you've been here long enough. Time to clean up and get outta here!"
		content.sound = sound
		
		// Setup notification trigger
		let triggerTimeInterval = Double(secondsRemaining)
		print(triggerTimeInterval) // TODO: Remove
		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: triggerTimeInterval, repeats: false)
		
		// Setup request
		let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
		
		center.add(request)
	}
	
	func removePendingLocalNotifications() {
		let center = UNUserNotificationCenter.current()
		center.removeAllPendingNotificationRequests()
	}
}
