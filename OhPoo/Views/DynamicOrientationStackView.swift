//
//  DynamicOrientationStackView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 2/16/24.
//

import SwiftUI

struct DynamicOrientationStackView<Content: View>: View {
	// View Contents to import
	var content: Content
	// Used to determine layout of on-screen elements
	@Environment(\.verticalSizeClass) private var verticalSizeClass: UserInterfaceSizeClass?
	@Environment(\.horizontalSizeClass) private var horizontalSizeClass: UserInterfaceSizeClass?
	var isLikelyiPhonePortrait: Bool {
		horizontalSizeClass == .compact && verticalSizeClass == .regular
	}
	var isLikelyiPhoneLandscape: Bool {
		horizontalSizeClass == .compact && verticalSizeClass == .compact
	}
	var isLikelyiPad: Bool {
		horizontalSizeClass == .regular && verticalSizeClass == .regular
	}
	var uncertainDeviceAndOrientation: Bool {
		horizontalSizeClass == .regular && verticalSizeClass == .compact
	}
	
	var body: some View {
		if isLikelyiPhonePortrait || isLikelyiPad {
			VStack {
				content
			}
		}
		if isLikelyiPhoneLandscape || uncertainDeviceAndOrientation {
			HStack {
				content
			}
		}
    }
}
