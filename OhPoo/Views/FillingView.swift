//
//  FillingView.swift
//  OhPoo
//
//  Created by Carlo Jacob on 2/12/24.
//

import Foundation
import SwiftUI

struct FillingView: Shape {
	let endTime: Int
	let remainingTime: Int
	
	func path(in rect: CGRect) -> Path {
		let rectangleHeightMultiplier = max(0.85 * (Double(remainingTime) / Double(endTime)), 0.0)
		let rectangle = CGRect(x: rect.minX, y: rect.maxY, width: rect.width, height: -rect.height * rectangleHeightMultiplier)
		return Path { path in
			path.addRect(rectangle)
		}
	}
}
