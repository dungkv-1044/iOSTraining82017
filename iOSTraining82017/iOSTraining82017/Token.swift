//
//  Token.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/29/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import SwiftyJSON
class Token: NSObject, NSCoding {
    var refreshToken: String?
    var accessToken: String?
    init?(json: JSON) {
        self.refreshToken = json[JSONTokenKey.refreshToken].stringValue
        self.accessToken = json[JSONTokenKey.accessToken].stringValue
    }
    required init(coder decoder: NSCoder) {
        self.refreshToken = decoder.decodeObject(forKey: JSONTokenKey.refreshToken) as? String
        self.accessToken = decoder.decodeObject(forKey: JSONTokenKey.accessToken) as? String
    }
    func encode(with coder: NSCoder) {
        coder.encode(refreshToken, forKey: JSONTokenKey.refreshToken)
        coder.encode(accessToken, forKey: JSONTokenKey.accessToken)
    }
}
