//
//  OhPooApp.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import SwiftUI

@main
struct OhPooApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	@StateObject var pooTimer = PooTimer()
	
    var body: some Scene {
        WindowGroup {
            HomeView()
				.environmentObject(pooTimer)
        }
    }
}
