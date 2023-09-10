public class CobaltRequest: Codable {
    public var url: String
    public var vCodec: String
    public var vQuality: Int
    public var aFormat: String
    public var isAudioOnly: Bool
    public var isNoTTWatermark: Bool
    public var isTTFullAudio: Bool
    public var isAudioMuted: Bool
    public var dubLang: Bool

    public init(url: String) {
        self.url = url
        // Set default values for other properties
        self.vCodec = VideoCodec.h264.rawValue
        self.vQuality = 720
        self.aFormat = AudioType.mp3.rawValue
        self.isAudioOnly = false
        self.isNoTTWatermark = false
        self.isTTFullAudio = true
        self.isAudioMuted = false
        self.dubLang = false
    }

    public init(url: String, vCodec: String, vQuality: Int, aFormat: String, isAudioOnly: Bool, isNoTTWatermark: Bool, isTTFullAudio: Bool, isAudioMuted: Bool, dubLang: Bool) {
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

    // Implement the required Codable initializers
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode(String.self, forKey: .url)
        self.vCodec = try container.decode(String.self, forKey: .vCodec)
        self.vQuality = try container.decode(Int.self, forKey: .vQuality)
        self.aFormat = try container.decode(String.self, forKey: .aFormat)
        self.isAudioOnly = try container.decode(Bool.self, forKey: .isAudioOnly)
        self.isNoTTWatermark = try container.decode(Bool.self, forKey: .isNoTTWatermark)
        self.isTTFullAudio = try container.decode(Bool.self, forKey: .isTTFullAudio)
        self.isAudioMuted = try container.decode(Bool.self, forKey: .isAudioMuted)
        self.dubLang = try container.decode(Bool.self, forKey: .dubLang)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        try container.encode(vCodec, forKey: .vCodec)
        try container.encode(vQuality, forKey: .vQuality)
        try container.encode(aFormat, forKey: .aFormat)
        try container.encode(isAudioOnly, forKey: .isAudioOnly)
        try container.encode(isNoTTWatermark, forKey: .isNoTTWatermark)
        try container.encode(isTTFullAudio, forKey: .isTTFullAudio)
        try container.encode(isAudioMuted, forKey: .isAudioMuted)
        try container.encode(dubLang, forKey: .dubLang)
    }

    private enum CodingKeys: String, CodingKey {
        case url
        case vCodec
        case vQuality
        case aFormat
        case isAudioOnly
        case isNoTTWatermark
        case isTTFullAudio
        case isAudioMuted
        case dubLang
    }
}
