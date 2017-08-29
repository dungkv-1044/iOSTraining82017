//
//  Post.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/9/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import SwiftyJSON
struct Post {
    var commentCnt: Int?
    var createdAt: String?
    var idPost: Int?
    var likeCnt: Int?
    var shareCnt: Int?
    var status: String?
    var type: String?
    var updatedAt: String?
    var userPost: User?
    init?(json: JSON) {
        self.commentCnt = json[JSONPostKey.comment_cnt].int
        self.createdAt = json[JSONPostKey.created_at].string
        self.idPost = json[JSONPostKey.id].int
        self.likeCnt = json[JSONPostKey.like_cnt].int
        self.shareCnt = json[JSONPostKey.share_cnt].int
        self.status = json[JSONPostKey.status].string
        self.type = json[JSONPostKey.type].string
        self.updatedAt = json[JSONPostKey.updated_at].string
        let jsonData = json[JSONPostKey.user_post]
        if let user = User(json: jsonData) {
            self.userPost = user
        }
    }
    static func createPost(data: JSON?) -> [Post]? {
        guard let _data = data else {
            return nil
        }
        var result: [Post] = []
        guard let posts = _data.array  else { return nil }
        for post in posts {
            let p = Post(json: post)
            guard let _p = p else {
                return nil
            }
            result.append(_p)
        }
        return result
    }
}
