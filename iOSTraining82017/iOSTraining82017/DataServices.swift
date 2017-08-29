//
//  DataServices.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/9/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
class DataServices {
    static let shared: DataServices = DataServices()
    let mainUrl = "https://www.getpostman.com/collections/4f7efb3c7e9d556e924f"
    private var _requestObjects: [RequestObject]?
    var requestObjects: [RequestObject] {
        set {
            _requestObjects = newValue
        }
        get {
            if _requestObjects == nil {
                requestJSONFromURL()
            }
            return _requestObjects ?? []
        }
    }
    var posts: [Post] = []
    func requestJSONFromURL() {
        Alamofire.request(mainUrl).responseJSON { (response) -> Void in
            switch response.result {
            case .success:
                guard let data = response.data else {return}
                let json = JSON(data: data)
                let requestObjects = RequestObject.createRequestObject(data: json)
                guard let _result = requestObjects else {return}
                self.requestObjects = _result
            case .failure(let error):
                print(error)
            }
        }
    }
    func login(username: String?, password: String?, completion: @escaping(Bool) -> Void) {
        guard let username = username else { return }
        guard let password = password else { return }
        let parameters = [
            "username": username,
            "password": password
        ]
        Alamofire.request(UserRouter.loginAccount(parameters: parameters)).responseJSON { (response) -> Void in
            switch response.result {
            case .success:
                guard let data = response.data else {return}
                let json = JSON(data: data)
                guard let tokenValue = Token.init(json: json) else {return}
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: tokenValue)
                UserDefaults.standard.set(encodedData, forKey: "tokenValue")
                completion(true)
                print(json)
            case .failure(let error):
                completion(false)
                print(error)
            }
        }
    }
    func requestAppInfo(completion: @escaping (AppInfo?) -> Void ) {
        Alamofire.request(AppRouter.getAppInfo()).responseJSON { (response) -> Void in
            switch response.result {
            case .success:
                guard let data = response.data else {return}
                let json = JSON(data: data)
                guard let info = AppInfo.init(json: json) else {return}
                completion(info)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
    func requestAllPost(completion: @escaping([Post]?) -> Void) {
        Alamofire.request(TimelineRouter.getTimeline()).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {return}
                let json = JSON(data: data)
                guard let _posts = Post.createPost(data: json) else {return}
                self.posts = _posts
//                print(json)
                completion(_posts)
            case .failure(let error):
                completion(nil)
                print(error)
            }
        }
    }
}
