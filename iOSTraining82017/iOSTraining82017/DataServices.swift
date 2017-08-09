//
//  DataServices.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/9/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
class DataServices {
    static let shared : DataServices = DataServices()
    
    private var _posts : [Post]?
    private var _indexPath : IndexPath?
    
    
    var indexPath : IndexPath? {
        set {
            _indexPath = newValue
        }
        get {
            return _indexPath
        }
    }
    var posts : [Post] {
        set {
            _posts = newValue
        }
        get {
            if _posts == nil {
                loadData()
            }
            return _posts ?? []
        }
    }
    
    private func loadData() {
        let p1 = Post(avaImg: #imageLiteral(resourceName: "ava_nhung_hoang"), nameUser: "Andrea Nhung", postTime: "2 hours", postType: "Public", postContent: "Abcdeasdsa", photoImg: #imageLiteral(resourceName: "ava_nhung_hoang"), totalComment: 200, totalLike: 1000)
        let p2 = Post(avaImg: #imageLiteral(resourceName: "ava"), nameUser: "Andrea BBB", postTime: "2 hours", postType: "Public", postContent: "AbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsa",totalComment: 200, totalLike: 1000)
        let p3 = Post(avaImg: #imageLiteral(resourceName: "ava_nhung_hoang"), nameUser: "Andrea HHH", postTime: "2 hours", postType: "Public", postContent: "Abcdeasdsa",photoImg: #imageLiteral(resourceName: "ava_nhung_hoang"), totalComment: 200, totalLike: 1000)
        let p4 = Post(avaImg: #imageLiteral(resourceName: "ava_nhung_hoang"), nameUser: "Andrea HHH", postTime: "2 hours", postType: "Public", postContent: "Abcdeasdsa",photoImg: #imageLiteral(resourceName: "ava_nhung_hoang"), totalComment: 200, totalLike: 1000)
        let p5 = Post(avaImg: #imageLiteral(resourceName: "ava"), nameUser: "Andrea BBB", postTime: "2 hours", postType: "Public", postContent: "AbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsaAbcdeasdsa",totalComment: 200, totalLike: 1000)
        let p6 = Post(avaImg: #imageLiteral(resourceName: "ava_nhung_hoang"), nameUser: "Andrea HHH", postTime: "2 hours", postType: "Public", postContent: "Abcdeasdsa",photoImg: #imageLiteral(resourceName: "ava"), totalComment: 200, totalLike: 1000)
        let p7 = Post(avaImg: #imageLiteral(resourceName: "ava_nhung_hoang"), nameUser: "Andrea HHH", postTime: "2 hours", postType: "Public", postContent: "Abcdeasdsa",photoImg: #imageLiteral(resourceName: "ava_nhung_hoang"), totalComment: 200, totalLike: 1000)
        let p8 = Post(avaImg: #imageLiteral(resourceName: "ava"), nameUser: "Andrea BBB", postTime: "2 hours", postType: "Public", postContent: "as",totalComment: 200, totalLike: 1000)
        let p9 = Post(avaImg: #imageLiteral(resourceName: "ava"), nameUser: "Andrea BBB", postTime: "2 hours", postType: "Public", postContent: "1231321",totalComment: 200, totalLike: 1000)
        _posts = [p1,p2,p3,p4,p5,p8,p9,p6,p7]
    }
}
