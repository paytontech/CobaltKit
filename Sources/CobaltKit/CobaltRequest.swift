//
//  CobaltRequest.swift
//  
//
//  Created by Payton Curry on 9/10/23.
//

import Foundation
public class CobaltRequest: Codable {
    init(url: String) {
        //default settings
        self.url = url
    }
    init(url: String, vCodec: String, vQuality: Int, aFormat: String, isAudioOnly: Bool, isNoTTWatermark: Bool, isTTFullAudio: Bool, isAudioMuted: Bool, dubLang: Bool) {
        self.url = url
        self.vCodec = vCodec
        self.vQuality = vQuality
        self.aFormat = aFormat
        self.isAudioOnly = isAudioOnly
        self.isNoTTWatermark = isNoTTWatermark
        self.isTTFullAudio = isTTFullAudio
        self.isAudioMuted = isAudioMuted
        self.dubLang = dubLang
    }
    var url: String
    var vCodec: String = VideoCodec.h264.rawValue
    var vQuality: Int = 720
    var aFormat: String = AudioType.mp3.rawValue
    var isAudioOnly: Bool = false
    var isNoTTWatermark: Bool = false
    var isTTFullAudio: Bool = true
    var isAudioMuted: Bool = false
    var dubLang: Bool = false
}
