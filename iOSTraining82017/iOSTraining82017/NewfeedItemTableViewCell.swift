//
//  NewfeedItemTableViewCell.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/9/17.
//  Copyright © 2017 Framgia. All rights reserved.
//


import UIKit
protocol NewfeedItemProtocol : NSObjectProtocol {
    func returnIndexPath(selectedIndexPath: Int?)
}
struct ConfigCellString {
    static let textType = " · Medium · "
    static let textLike = " Likes"
    static let textComment = " Comments"
}
class NewfeedItemTableViewCell: UITableViewCell {
    @IBOutlet private  weak var nameUser: UILabel!
    @IBOutlet private weak var postTime: UILabel!
    @IBOutlet private weak var avaImg: UIImageView!
    @IBOutlet private weak var postTypeImg: UIImageView!
    @IBOutlet private weak var postContent: UILabel!
    @IBOutlet private weak var photoImg: UIImageView!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var likeLabel: UILabel!
    @IBOutlet private weak var constantPhotoImgHeight: NSLayoutConstraint!
    @IBOutlet private weak var constantPhotoImgTopSpacing: NSLayoutConstraint!
    var indexPath: Int?
    //MARK: Delegate
    var delegate: NewfeedItemProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameUser.text = ""
        self.postTime.text = ""
        self.avaImg.image = nil
        self.postTypeImg.image = nil
        self.postContent.text = ""
        self.photoImg.image = nil
        self.commentLabel.text = ""
        self.likeLabel.text = ""
        constantPhotoImgHeight.constant = 200
        constantPhotoImgTopSpacing.constant = 10
      
    }
    
    func configureCell(post: Post, indexPath: IndexPath) {
        self.indexPath = indexPath.section
        self.nameUser.text = post.nameUser
        if let posttime = post.postTime {
             self.postTime.text = posttime + ConfigCellString.textType
        }
        self.avaImg.image = post.avaImg
        self.postTypeImg.image = #imageLiteral(resourceName: "icon-globe_asia_filled")
        self.postContent.text = post.postContent
        if post.photoImg != nil {
            self.photoImg.image = post.photoImg
        } else {
            constantPhotoImgHeight.constant = 0
            constantPhotoImgTopSpacing.constant = 0
        }
        if let totalLike = post.totalLike {
            self.likeLabel.text = "\(totalLike)" + ConfigCellString.textLike
        }
        if let totalComment = post.totalComment {
            self.commentLabel.text = "\(totalComment)" + ConfigCellString.textComment
        }
        
        
    }
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        delegate?.returnIndexPath(selectedIndexPath: indexPath)
    }
    
}
