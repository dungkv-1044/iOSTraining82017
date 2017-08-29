//
//  Key.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
struct ImageIdentifier {
    static let backgroundImage = "BackgroundImage"
    static let avatarImage = "AvatarImage"
}
struct TakePhotoActionSheet {
    static let title = "Action sheet"
    static let message = "What would you like to do? "
}
struct MessageText {
    static let titleMessage = "Missing information!"
    static let nameMessage = "Name must be filled!"
    static let emailMessage = "Email must be filled!"
    static let phoneMessage = "Phone must be filled!"
    static let actionTitle = "Close"
}
struct ActionSheet {
    static let pickPhoto = "Pick Photo"
    static let takePhoto = "Take Photo"
    static let cancel = "Cancel"
}
struct LoginError {
    static let titleWrongInputType = "Wrong input format"
    static let titleLoginFail = "Username or password are incorrect."
    static let messageInvalid = "Invalid email format. Please input a correct email."
    static let messageMustFilled = "Email and Password must be filled."
    static let messageMustGreater = "Email and Password must be greater than 6 chacracters."
    static let messageLoginFail = "Username or password are incorrect."
    static let actionTitle = "Close"
}
struct TabBarTitle {
    static let timeline = "Timeline"
    static let profile = "Profile"
    static let more = "More"
}
