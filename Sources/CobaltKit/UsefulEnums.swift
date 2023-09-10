//
//  UsefulEnums.swift
//
//
//  Created by Payton Curry on 9/10/23.
//

import Foundation
public enum CobaltError: Error {
    case itsFucked
}
public enum PickerType: String, Codable {
    case various = "various"
    case images = "images"
}

public enum CobaltResStatus: String, Codable {
    case error = "error"
    case redirect = "redirect"
    case stream = "stream"
    case rateLimit = "rate-limit"
    case picker = "picker"
}

public enum VideoCodec: String {
    case h264 = "h264"
    case av1 = "av1"
    case vp9 = "vp9"
}
public enum AudioType: String {
    case best = "best"
    case mp3 = "mp3"
    case ogg = "ogg"
    case wav = "wav"
    case opus = "opus"
}

