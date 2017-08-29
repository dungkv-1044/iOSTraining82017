//
//  AppInfo.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/29/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import SwiftyJSON
struct AppInfo {
    var currentVersion: String?
    var status: String?
    var updateRequired: Bool?
    init?(json: JSON) {
        self.currentVersion = json["current_version"].stringValue
        self.status = json["status"].stringValue
        self.updateRequired = json["update_required"].boolValue
    }
    static func createAppInfo(data: JSON?) -> AppInfo? {
        guard let _data = data else {
            return nil
        }
        guard let appInfo = AppInfo.init(json: _data) else {
            return nil
        }
        return appInfo
    }
}
