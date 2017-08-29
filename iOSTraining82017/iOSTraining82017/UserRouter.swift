//
//  UserRouter.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/31/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import Alamofire
enum UserRouter: URLRequestConvertible {
    static let baseURLString = "https://us-central1-travelworld-5d555.cloudfunctions.net/v1"
    case loginAccount(parameters: Parameters)
    var method: HTTPMethod {
        switch self {
        case .loginAccount:
            return .post
        }
    }
    var path: String {
        switch self {
        case .loginAccount:
            return "/user/login"
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = try AppRouter.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .loginAccount(let parameters):
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        }
        return urlRequest
    }
}
