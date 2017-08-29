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
        self.key = json["key"].string
        self.value = json["value"].string
        self.description = json["value"].string
        self.enabled = json["enabled"].bool
    }
}
