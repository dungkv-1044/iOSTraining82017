//
//  Key.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
struct ParameterKey {
    static let username                 = "username"
    static let password                 = "password"
}
struct HeaderKey {
    static let ContentType              = "Content-Type"
    static let Authorization            = "Authorization"
    static let Accept                   = "Accept"
}

struct HeaderValue {
    static let ApplicationJson                     = "application/json"
    static let ApplicationOctetStream              = "application/octet-stream"
    static let ApplicationXWWWFormUrlencoded       = "application/x-www-form-urlencoded"
}
struct JSONTokenKey {
    static let refreshToken             = "refresh_token"
    static let accessToken              = "access_token"
}
struct JSONPostKey {
    static let comment_cnt              = "comment_cnt"
    static let created_at               = "created_at"
    static let id                       = "id"
    static let like_cnt                 = "like_cnt"
    static let share_cnt                = "share_cnt"
    static let status                   = "status"
    static let type                     = "type"
    static let updated_at               = "updated_at"
    static let user_post                = "user_post"
}
struct JSONUserKey {
    static let id                       = "id"
}
struct JSONRequestObject {
    static let requests                 = "requests"
    static let id                       = "id"
    static let headers                  = "headers"
    static let url                      = "url"
    static let name                     = "name"
    static let time                     = "time"
    static let headerData               = "headerData"
}
struct JSONHeaderData {
    static let key                      = "key"
    static let value                    = "value"
    static let description              = "description"
    static let enabled                  = "enabled"
}
struct JSONAppInfo {
    static let current_version          = "current_version"
    static let status                   = "status"
    static let update_required          = "update_required"
}
