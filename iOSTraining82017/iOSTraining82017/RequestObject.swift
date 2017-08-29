//
//  RequestObject.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/29/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import SwiftyJSON
struct RequestObject {
    var idRequest: String?
    var headers: String?
    var headerData: [HeaderData] = []
    var url: String?
    var name: String?
    var time: TimeInterval?
    init?(json: JSON) {
        self.idRequest = json[JSONRequestObject.id].string
        self.headers = json[JSONRequestObject.headers].string
        self.url = json[JSONRequestObject.url].string
        self.name = json[JSONRequestObject.name].string
        self.time = json[JSONRequestObject.time].double
        guard let jsonData = json[JSONRequestObject.headerData].array else {
            return
        }
        for jsonHData in jsonData {
            if let hData = HeaderData(json: jsonHData) {
                self.headerData.append(hData)
            }
        }
    }
    static func createRequestObject(data: JSON?) -> [RequestObject]? {
        guard let _data = data else {
            return nil
        }
        var result: [RequestObject] = []
        guard let requestObject = _data[JSONRequestObject.requests].array  else { return nil }
        for requestObj in requestObject {
            let reObj = RequestObject(json: requestObj)
            guard let _reObj = reObj else {
                return nil
            }
            result.append(_reObj)
        }
        return result
    }
}
