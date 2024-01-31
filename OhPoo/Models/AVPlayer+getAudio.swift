//
//  AVPlayer+getAudio.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import Foundation
import AVFoundation

extension AVPlayer {
	static func getAudioPlayer(audioFilename: String) -> AVPlayer {
		if audioFilename == "fart-05" {
			return .getFartAudioPlayer
		}
		if audioFilename == "toilet-flush-2" {
			return .getFlushAudioPlayer
		}
		return AVPlayer()
	}
	
	static let getFartAudioPlayer: AVPlayer = {
		guard let url = Bundle.main.url(forResource: "fart-05", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
		return AVPlayer(url: url)
	}()
	
	static let getFlushAudioPlayer: AVPlayer = {
		guard let url = Bundle.main.url(forResource: "toilet-flush-2", withExtension: "mp3") else { fatalError("Failed to find sound file.") }
		return AVPlayer(url: url)
	}()
}
