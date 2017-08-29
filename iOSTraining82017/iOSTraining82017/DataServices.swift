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
    var request: Request?
    var posts: [Post] = []
    func login(username: String?, password: String?, completion: @escaping(Bool) -> Void) {
        guard let username = username else { return }
        guard let password = password else { return }
        let parameters = [
            ParameterKey.username: username,
            ParameterKey.password: password
        ]
        self.request = ApiClient.request(urlRequest: UserRouter.loginAccount(parameters: parameters), completionHandler: { [weak self](responseObject) in
            guard self != nil else { return }
            if responseObject?.result == .success {
                guard let data = responseObject?.data else {return}
                let json = JSON(data)
                guard let tokenValue = Token.init(json: json) else {return}
                let encodedData = NSKeyedArchiver.archivedData(withRootObject: tokenValue)
                UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.tokenValue)
                completion(true)
            } else {
                if responseObject?.result == .error {
                    completion(false)
                }
            }
        })
    }
    func requestAppInfo(completion: @escaping (AppInfo?) -> Void ) {
        self.request = ApiClient.request(urlRequest: AppRouter.getAppInfo(), completionHandler: { [weak self](responseObject) in
            guard self != nil else { return }
            if responseObject?.result == .success {
                guard let data = responseObject?.data else {return}
                let json = JSON(data)
                guard let info = AppInfo.init(json: json) else {return}
                completion(info)
            } else {
                if responseObject?.result == .error {
                }
            }
        })
    }
    
    func requestAllPost(completion: @escaping([Post]?) -> Void) {
        self.request = ApiClient.request(urlRequest: TimelineRouter.getTimeline(), completionHandler: { [weak self](responseObject) in
            guard let strongSelf = self else { return }
            if responseObject?.result == .success {
                guard let data = responseObject?.data else {return}
                let json = JSON(data)
                guard let _posts = Post.createPost(data: json) else {return}
                strongSelf.posts = _posts
                completion(_posts)
            } else {
                if responseObject?.result == .error {
                    completion(nil)
                }
            }
            
        })
    }
    func cancelRequest() {
        self.request?.cancel()
        self.request = nil
    }
}
