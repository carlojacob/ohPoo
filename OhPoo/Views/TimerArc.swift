//
//  TimerArc.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import Foundation
import SwiftUI

struct TimerArc: Shape {
	let startTime: Int = 0
	let endTime: Int
	let currentTime: Int
	let startAngle: Angle = Angle(degrees: -1)
	let endAngle: Angle = Angle(degrees: -359)

	private var degreesPerSecond: Double {
		360.0 / Double(startTime - endTime)
	}
	
	private var progressAngle: Angle {
		Angle(degrees: max(-359.0, min(-1, -degreesPerSecond * Double(currentTime))))
	}

	func path(in rect: CGRect) -> Path {
		let diameter = min(rect.size.width, rect.size.height) - 30.0
		let radius = diameter / 2.0
		let center = CGPoint(x: rect.midX, y: rect.midY)
		return Path { path in
			path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: progressAngle, clockwise: false)
		}
	}
}
