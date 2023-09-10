//
//  Picker.swift
//  
//
//  Created by Payton Curry on 9/10/23.
//

import Foundation
public class Picker: Codable {
    public init(type: String, url: String, thumb: String) {
        self.type = type
        self.url = url
        self.thumb = thumb
    }
    var type: String
    var url: String
    var thumb: String
}
