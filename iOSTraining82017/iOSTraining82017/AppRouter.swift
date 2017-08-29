//
//  AppRouter.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/30/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import Alamofire
enum AppRouter: URLRequestConvertible {
    static let baseURLString = "https://us-central1-travelworld-5d555.cloudfunctions.net/v1"
    case getAppInfo()
    var method: HTTPMethod {
        switch self {
        case .getAppInfo:
            return .get
        }
    }
    var path: String {
        switch self {
        case .getAppInfo:
            return "/appinfo"
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = try AppRouter.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .getAppInfo():
            urlRequest = try URLEncoding.default.encode(urlRequest, with: nil)
        }
        return urlRequest
    }
}
