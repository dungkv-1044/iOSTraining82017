//
//  User.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/17/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import SwiftyJSON
struct PropertyKey {
    static let backgroundImage = "backgroundImage"
    static let avatarImage = "avatarImage"
    static let userName = "userName"
    static let emailAddress = "emailAddress"
    static let phoneNumber = "phoneNumber"
    static let dob = "dob"
}
class User: NSObject, NSCoding {
    var backgroundImage: UIImage?
    var avatarImage: UIImage?
    var userName: String?
    var emailAddress: String?
    var phoneNumber: String?
    var dob: String?
    var idUser: Int?
    init?(json: JSON) {
        self.idUser = json[JSONUserKey.id].int
    }
    init(backgroundImage: UIImage, avatarImage: UIImage, userName: String, emailAddress: String, phoneNumber: String, dob: String ) {
        self.backgroundImage = backgroundImage
        self.avatarImage = avatarImage
        self.userName = userName
        self.emailAddress = emailAddress
        self.phoneNumber = phoneNumber
        self.dob = dob
    }
    required init(coder decoder: NSCoder) {
        self.backgroundImage = decoder.decodeObject(forKey: PropertyKey.backgroundImage) as? UIImage
        self.avatarImage = decoder.decodeObject(forKey: PropertyKey.avatarImage) as? UIImage
        self.userName = decoder.decodeObject(forKey: PropertyKey.userName) as? String
        self.emailAddress = decoder.decodeObject(forKey: PropertyKey.emailAddress) as? String
        self.phoneNumber = decoder.decodeObject(forKey: PropertyKey.phoneNumber) as? String
        self.dob = decoder.decodeObject(forKey: PropertyKey.dob) as? String
    }
    func encode(with coder: NSCoder) {
        coder.encode(backgroundImage, forKey: PropertyKey.backgroundImage)
        coder.encode(avatarImage, forKey: PropertyKey.avatarImage)
        coder.encode(userName, forKey: PropertyKey.userName)
        coder.encode(emailAddress, forKey: PropertyKey.emailAddress)
        coder.encode(phoneNumber, forKey: PropertyKey.phoneNumber)
        coder.encode(dob, forKey: PropertyKey.dob)
    }
}
