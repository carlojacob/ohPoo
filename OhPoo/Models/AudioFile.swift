//
//  AudioFile.swift
//  OhPoo
//
//  Created by Carlo Jacob on 2/14/24.
//

import Foundation

enum AudioFile {
	case fart
	case flush
	case flushShort
	
	var filename: String {
		switch self {
		case .fart:
			"fart-05"
		case .flush:
			"toilet-flush-2"
		case .flushShort:
			"toilet-flush-2-short"
		}
	}
	
	var fileExtension: String {
		return "mp3"
	}
}
