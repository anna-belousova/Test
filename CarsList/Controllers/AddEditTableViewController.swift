//
//  ViewController.swift
//  CarsList
//
//  Created by MacBook Air on 02/10/2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

var selectedImage: UIImage?

class AddEditTableViewController: UITableViewController {
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var manufacturerTextField: UITextField!
    @IBOutlet var modelTextField: UITextField!
    @IBOutlet var bodyTypeTextField: UITextField!
    @IBOutlet var productionYearTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var uploadPhoto: UIButton!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var user: User!
    var cars = Car()
    var bodyTypesArray: Array<String> = []
    var productionYearArray: Array<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productionYearArray = cars.createProductionYearArray()
        bodyTypesArray = cars.createBodyTypeArray()
        uploadUI()
        createBodyTypePicker()
        createProductionYearPicker()
        textFieldsChanged()
        
        saveButton.isEnabled = false
        manufacturerTextField.delegate = self
        modelTextField.delegate = self
        bodyTypeTextField.delegate = self
        productionYearTextField.delegate = self
        priceTextField.delegate = self
    }
    
    func uploadUI() {
        manufacturerTextField.text = cars.manufacturer
        modelTextField.text = cars.model
        bodyTypeTextField.text = cars.bodyType
        productionYearTextField.text = "\(cars.productionYear)"
        priceTextField.text = "\(cars.price)"
        photo.loadImagesUsingCache(urlString: cars.urlPhoto)
    }
        
    func updateCar() {
        cars.manufacturer = manufacturerTextField.text ?? ""
        cars.model = modelTextField.text ?? ""
        cars.bodyType = bodyTypeTextField.text ?? ""
        cars.productionYear = Int(productionYearTextField.text ?? "0") ?? 0
        cars.price = Int(priceTextField.text ?? "0") ?? 0
    }
    
    func textFieldsChanged() {
        manufacturerTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        modelTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        priceTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }

}

extension AddEditTableViewController: UITextFieldDelegate {
    @objc func textFieldDidChange() {
        if !manufacturerTextField.text!.isEmpty && !modelTextField.text!.isEmpty && !bodyTypeTextField.text!.isEmpty && !productionYearTextField.text!.isEmpty && !priceTextField.text!.isEmpty && productionYearTextField.text != "0" && priceTextField.text != "0" {
            saveButton.isEnabled = true
            print(selectedImage)
        }
        
    }
}

//    func createUser() {
//        guard let currentUser = Auth.auth().currentUser else { return }
//        user.uid = currentUser.uid
//        user.email = currentUser.email ?? ""
//        ref = Database.database().reference(withPath: "users").child(user.uid).child("car")
 //   }
    
    




