//
//  UpdateProfileViewController.swift
//  iOSTraining82017
//
//  Created by Khuat Van Dung on 8/16/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import os.log

class UpdateProfileViewController: UITableViewController {
    @IBOutlet private weak var backgroundImage: UIImageView!
    @IBOutlet private weak var saveButton: UIBarButtonItem!
    @IBOutlet private weak var userName: UITextField!
    @IBOutlet private weak var emailAddress: UITextField!
    @IBOutlet private weak var phoneNumber: UITextField!
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var dob: UIDatePicker!
    var identifier = ""
    var bgrImage: UIImage? {
        didSet {
            backgroundImage.image = bgrImage
        }
    }
    var avaImage: UIImage? {
        didSet {
            avatarImage.image = avaImage
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            return
        }
        guard userName.text != "" else {
            showAlertMessage(title: MessageText.titleMessage, message: MessageText.nameMessage, titleAction: MessageText.actionTitle)
            return
        }
        guard emailAddress.text != "" else {
            showAlertMessage(title: MessageText.titleMessage, message: MessageText.emailMessage, titleAction: MessageText.actionTitle)
            return
        }
        guard phoneNumber.text != "" else {
            showAlertMessage(title: MessageText.titleMessage, message: MessageText.phoneMessage, titleAction: MessageText.actionTitle)
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        let date = dateFormatter.string(from: dob.date)
        let user = User(backgroundImage: backgroundImage.image!, avatarImage: avatarImage.image!, userName: userName.text!, emailAddress: emailAddress.text!, phoneNumber: phoneNumber.text!, dob: date)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.set(encodedData, forKey: UserDefaultKey.user)
    }
 
    @IBAction private func selectBackgroundImage(_ sender: UIButton) {
        showActionSheet(title: TakePhotoActionSheet.title, message: TakePhotoActionSheet.message)
        identifier = ImageIdentifier.backgroundImage
    }
    @IBAction private func selectAvatarImage(_ sender: UIButton) {
        showActionSheet(title: TakePhotoActionSheet.title, message: TakePhotoActionSheet.message)
        identifier = ImageIdentifier.avatarImage
    }
    // Image picker
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
            os_log("Camera is not available", log: .default, type: .info)
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
    
}
extension UpdateProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if identifier == ImageIdentifier.avatarImage {
            avaImage = info[UIImagePickerControllerEditedImage] as? UIImage
        }
        if identifier == ImageIdentifier.backgroundImage {
            bgrImage = info[UIImagePickerControllerEditedImage] as? UIImage
        }
        dismiss(animated:true, completion: nil)
    }
}
