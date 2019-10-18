//
//  UploadPhoto.swift
//  CarsList
//
//  Created by MacBook Air on 09/10/2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseStorage

extension AddEditTableViewController {
        
    @IBAction func uploadPhotoTapped(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Please choose image source", message: nil, preferredStyle: .actionSheet)
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }
            alert.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { action in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
            alert.addAction(photoLibraryAction)
        }
        cancelAction(alert, sender)
      }
    
    func cancelAction(_ alert: UIAlertController, _ sender: UIButton) {
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = sender
        present(alert, animated: true)
    }
}

extension AddEditTableViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[.originalImage] as? UIImage
        photo.image = selectedImage
        dismiss(animated: true)
        textFieldDidChange()
    }
}

extension AddEditTableViewController: UINavigationControllerDelegate { }
