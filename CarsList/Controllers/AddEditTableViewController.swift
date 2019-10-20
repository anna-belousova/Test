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
    
    var cars = Car()
    var bodyTypesArray: Array<String> = []
    var productionYearArray: Array<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productionYearArray = cars.createProductionYearArray()
        bodyTypesArray = cars.createBodyTypeArray()
        createBodyTypeAndProductionYearPicker()
        uploadUI()
        textFieldsChanged()
        hideKeyboard()
        
        saveButton.isEnabled = false
        manufacturerTextField.delegate = self
        modelTextField.delegate = self
        bodyTypeTextField.delegate = self
        productionYearTextField.delegate = self
        priceTextField.delegate = self
        photo.layer.cornerRadius = 15
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && view.bounds.size.height > view.bounds.size.width {
            let aspectRatio: CGFloat = 266/896
            return aspectRatio * view.bounds.size.height
        }
        if indexPath.section == 0 && view.bounds.size.height < view.bounds.size.width {
            let aspectRatio: CGFloat = 250/414
            return aspectRatio * view.bounds.size.height
        }
        return UITableView.automaticDimension
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
        cars.dateOfAdding = getDate(for: Date())
    }
    
    func getDate(for date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
    
    func textFieldsChanged() {
        manufacturerTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        modelTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
        priceTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        self.view.addGestureRecognizer(tap)
    }
}

extension AddEditTableViewController: UITextFieldDelegate {
    @objc func textFieldDidChange() {
        if !manufacturerTextField.text!.isEmpty && !modelTextField.text!.isEmpty && !bodyTypeTextField.text!.isEmpty && !productionYearTextField.text!.isEmpty && !priceTextField.text!.isEmpty && productionYearTextField.text != "0" && priceTextField.text != "0" {
            saveButton.isEnabled = true
        }
    }
}





