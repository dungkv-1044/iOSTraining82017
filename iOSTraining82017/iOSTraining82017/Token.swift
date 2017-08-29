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
        self.refreshToken = json["refresh_token"].stringValue
        self.accessToken = json["access_token"].stringValue
    }
    required init(coder decoder: NSCoder) {
        self.refreshToken = decoder.decodeObject(forKey: "refress_token") as? String
        self.accessToken = decoder.decodeObject(forKey: "access_token") as? String
    }
    func encode(with coder: NSCoder) {
        coder.encode(refreshToken, forKey: "refress_token")
        coder.encode(accessToken, forKey: "access_token")
    }
}
