//
//  HeaderData.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/29/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import SwiftyJSON
struct HeaderData {
    var key: String?
    var value: String?
    var description: String?
    var enabled: Bool?
    init?(json: JSON) {
        self.key = json[JSONHeaderData.key].string
        self.value = json[JSONHeaderData.value].string
        self.description = json[JSONHeaderData.description].string
        self.enabled = json[JSONHeaderData.enabled].bool
    }
}
