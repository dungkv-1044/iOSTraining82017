//
//  UpdateStatusViewController.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/10/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class UpdateStatusViewController: UIViewController {
    @IBOutlet private weak var bottonViewConstant: NSLayoutConstraint!
    @IBOutlet private weak var viewFeature: UIView!
    @IBOutlet private weak var bottomViewFeatureConstant: NSLayoutConstraint!
    @IBOutlet private var swipeDown: UISwipeGestureRecognizer!
    @IBOutlet private var swipeUp: UISwipeGestureRecognizer!
    @IBOutlet private weak var imageViewStatus: UIImageView!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    @IBOutlet private weak var tvStatusContent: UITextView!
    var post: Post?
    var selectedImage: UIImage? {
        didSet {
            imageViewStatus.image = selectedImage
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(UpdateStatusViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
//        let postContent = tvStatusContent.text ?? ""
//        let photoImg = imageViewStatus.image
//        post = Post(avaImg: #imageLiteral(resourceName: "ava_nhung_hoang"), nameUser: "Andrea Test", postTime: "2 minutes", postType: "Public", postContent: postContent, photoImg: photoImg!, totalComment: 9, totalLike: 999)
    }
    // MARK: Action
    @IBAction private func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction private func swipeUp(_ sender: UISwipeGestureRecognizer) {
        self.bottonViewConstant.constant = 0
        imageViewStatus.isHidden = true
        runAnimate()
        viewFeature.isHidden = true
    }
    @IBAction private func swipeDown(_ sender: UISwipeGestureRecognizer) {
        swipeDownConfig()
    }
    @IBAction private func viewFeatureTapped(_ sender: UITapGestureRecognizer) {
        viewFeatureTappedConfig()
    }
    @IBAction private func pickPhotoTapped(_ sender: UITapGestureRecognizer) {
       showActionSheet(title: TakePhotoActionSheet.title, message: TakePhotoActionSheet.message)
    }
    // MARK: Image picker
    func showActionSheet(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: ActionSheet.pickPhoto, style: .default, handler: pickPhoto))
        alert.addAction(UIAlertAction(title: ActionSheet.takePhoto, style: .default, handler: takePhoto))
        alert.addAction(UIAlertAction(title: ActionSheet.cancel, style: .cancel, handler: { (_) -> Void in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    func takePhoto(action: UIAlertAction) {
        unowned let weakself = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = weakself as UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            weakself.present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera is not available")
        }
    }
    func pickPhoto(action: UIAlertAction) {
        unowned let weakself = self
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = weakself as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        weakself.present(imagePicker, animated: true, completion: nil)
    }
    // MARK: Private function
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                keyboardShowConfig(keyboardSize: keyboardSize)
            }
        }
    }
    func swipeDownConfig() {
        self.bottonViewConstant.constant = -224
        self.bottomViewFeatureConstant.constant = 0
        runAnimate()
        imageViewStatus.isHidden = false
        self.viewFeature.isHidden = false
    }
    func viewFeatureTappedConfig() {
        self.view.endEditing(true)
        self.viewFeature.isHidden = true
        self.bottomViewFeatureConstant.constant = 0
        self.swipeUp.isEnabled = true
        self.swipeDown.isEnabled = true
        self.bottonViewConstant.constant = 0
        runAnimate()
        imageViewStatus.isHidden = true
    }
    func keyboardShowConfig(keyboardSize: CGRect) {
        self.bottomViewFeatureConstant.constant = keyboardSize.height
        self.viewFeature.isHidden = false
        self.swipeUp.isEnabled = false
        self.swipeDown.isEnabled = false
        imageViewStatus.isHidden = true
    }
   
}

extension UpdateStatusViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        dismiss(animated:true, completion: nil)
        swipeDownConfig()
    }
}
