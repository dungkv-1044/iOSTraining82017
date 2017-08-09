//
//  Post.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/9/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
class Post {
    var avaImg: UIImage?
    var nameUser: String?
    var postTime: String?
    var postType: String?
    var postContent: String?
    var photoImg: UIImage?
    var totalComment: Int?
    var totalLike: Int?
    init(avaImg: UIImage, nameUser: String, postTime: String, postType: String, postContent: String, photoImg: UIImage, totalComment: Int, totalLike: Int) {
        self.avaImg = avaImg
        self.nameUser = nameUser
        self.postTime = postTime
        self.postType = postType
        self.postContent = postContent
        self.photoImg = photoImg
        self.totalLike = totalLike
        self.totalComment = totalComment
    }
    
    init(avaImg: UIImage, nameUser: String, postTime: String, postType: String, postContent: String, totalComment: Int, totalLike: Int) {
        self.avaImg = avaImg
        self.nameUser = nameUser
        self.postTime = postTime
        self.postType = postType
        self.postContent = postContent
        self.totalLike = totalLike
        self.totalComment = totalComment
    }
}

