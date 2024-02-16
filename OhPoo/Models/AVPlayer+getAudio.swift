//
//  AVPlayer+getAudio.swift
//  OhPoo
//
//  Created by Carlo Jacob on 1/30/24.
//

import Foundation
import AVFoundation

extension AVPlayer {
	static func getAudioPlayer(audioFilename: AudioFile) -> AVPlayer {
		switch audioFilename {
		case .fart:
			return getFartAudioPlayer
		case .flush:
			return getFlushAudioPlayer
		default:
			return AVPlayer()
		}
	}
	
	static let getFartAudioPlayer: AVPlayer = {
		let file = AudioFile.fart
		guard let url = Bundle.main.url(forResource: file.filename, withExtension: file.fileExtension) else { fatalError("Failed to find sound file.") }
		return AVPlayer(url: url)
	}()
	
	static let getFlushAudioPlayer: AVPlayer = {
		let file = AudioFile.flush
		guard let url = Bundle.main.url(forResource: file.filename, withExtension: file.fileExtension) else { fatalError("Failed to find sound file.") }
		return AVPlayer(url: url)
	}()
}
