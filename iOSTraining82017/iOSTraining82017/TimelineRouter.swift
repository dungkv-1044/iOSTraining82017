//
//  TimelineRouter.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/31/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import Alamofire
enum TimelineRouter: URLRequestConvertible {
    static let baseURLString = "https://us-central1-travelworld-5d555.cloudfunctions.net/v1"
    case getTimeline()
    var method: HTTPMethod {
        switch self {
        case .getTimeline:
            return .get
        }
    }
    var path: String {
        switch self {
        case .getTimeline:
            return "/timeline"
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = try AppRouter.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .getTimeline():
            guard let data = UserDefaults.standard.data(forKey: "tokenValue") else {break}
            guard let tokenValue = NSKeyedUnarchiver.unarchiveObject(with: data) as? Token else {break}
            guard let accessToken = tokenValue.accessToken else {break}
            let token = "JWT " + accessToken
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }
}
