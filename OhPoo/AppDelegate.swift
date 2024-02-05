//
//  AppDelegate.swift
//  OhPoo
//
//  Created by Carlo Jacob on 2/5/24.
//

import Foundation
import UIKit
import AVFoundation

class AppDelegate: NSObject, UIApplicationDelegate {
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
		let audioSession = AVAudioSession.sharedInstance()

		do {
			try audioSession.setCategory(.playback, options: .mixWithOthers)
			try audioSession.setActive(true)
		} catch {
			print("Unable to set up audio player: \(error.localizedDescription)")
		}
		return true
	}
}
