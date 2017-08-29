//
//  ViewDefine.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 9/7/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
struct Storyboard {
    struct Main {
        static let name                                 = "Main"
        static let startViewController                  = "StartViewController"
    }
    
    struct User {
        static let name                                 = "User"
        static let signinViewController                 = "SignInViewController"
        static let signupViewController                 = "SignUpViewController"
        static let profileViewController                = "ProfileTableViewController"
        static let updateProfileViewController          = "UpdateProfileViewController"
    }
    
    struct Timeline {
        static let name                                 = "Timeline"
        static let timelineTableViewController          = "TimelineTableViewController"
        static let timelineCommentContainerView         = "TimelineCommentContainerView"
        static let timelineCommentTableViewController   = "TimelineCommentTableViewController"
        static let updateStatusViewController           = "UpdateStatusViewController"
    }
    
    struct More {
        static let name                                 = "More"
        static let moreViewController                   = "MoreViewController"
    }
}
struct ReuseView {
    static let newfeedItem                              = "NewfeedItemTableViewCell"
    static let loadMoreCell                             = "LoadMoreCell"
}
struct SegueIdentifier {
    static let gotoTimelineCommentTVC                   = "TimelineCommentTVC"
    
}
