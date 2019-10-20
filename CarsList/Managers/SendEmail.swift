//
//  SendEmail.swift
//  CarsList
//
//  Created by MacBook Air on 21.10.2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//
import MessageUI

extension AddEditTableViewController {
    
   @IBAction func sendMessage(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {
            let alert = UIAlertController(title: "Your device cannot send an email", message: nil, preferredStyle: .alert)
            cancelAction(alert, sender)
            return
        }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients([cars.addedByUser])
        mailComposer.setSubject("\(cars.manufacturer) \(cars.model), \(cars.productionYear), id: \(cars.id)")
        mailComposer.setMessageBody("I want to buy your car, price: \(cars.price)$", isHTML: false)
        if let image = photo.image?.jpegData(compressionQuality: 1.0) {
            mailComposer.addAttachmentData(image, mimeType: "image", fileName: "\(cars.id).jpeg" )
        }
        present(mailComposer, animated: true)
    }
}

extension AddEditTableViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true)
    }
}

