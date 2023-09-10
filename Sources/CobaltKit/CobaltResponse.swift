//
//  CobaltResponse.swift
//
//
//  Created by Payton Curry on 9/10/23.
//

import Foundation
public class CobaltResponse: Codable {
    public init(status: CobaltResStatus, text: String? = nil, url: String? = nil, pickerType: PickerType? = nil, picker: Picker? = nil, audio: String? = nil) {
        self.status = status
        self.text = text
        self.url = url
        self.pickerType = pickerType
        self.picker = picker
        self.audio = audio
    }
    var status: CobaltResStatus
    var text: String? /* ??? waht is this <---- absolute DUMBASS its human readable status stuff */
    var url: String?
    var pickerType: PickerType?
    var picker: Picker?
    var audio: String?
}
