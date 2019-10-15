//
//  ViewController.swift
//  CarsList
//
//  Created by MacBook Air on 02/10/2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import UIKit
import Firebase

class AddEditTableViewController: UITableViewController {
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var manufacturerTextField: UITextField!
    @IBOutlet var modelTextField: UITextField!
    @IBOutlet var bodyTypeTextField: UITextField!
    @IBOutlet var productionYearTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var uploadPhoto: UIButton!
    
    var user: User!
    var ref = Database.database().reference(withPath: "cars")
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
        createUser()
    }

    func uploadUI() {
//        photo.image = cars.photo
        manufacturerTextField.text = cars.manufacturer
        modelTextField.text = cars.model
        bodyTypeTextField.text = cars.bodyType
        productionYearTextField.text = "\(cars.productionYear)"
        priceTextField.text = "\(cars.price)"
    }
        
    func updateCar() {
        cars.manufacturer = manufacturerTextField.text ?? ""
        cars.model = modelTextField.text ?? ""
        cars.bodyType = bodyTypeTextField.text ?? ""
        cars.productionYear = Int(productionYearTextField.text!)!
        cars.price = Int(priceTextField.text!)!
        cars.id = cars.createUniqueId()
//
//        let car = Car(id: "new1", manufacturer: manufacturerTextField.text!, model: modelTextField.text!, productionYear: Int(productionYearTextField.text!)!, bodyType: bodyTypeTextField.text!, photo: "", price: Int(priceTextField.text!)!)
//        ref.setValue(car.toAnyObject())
        
//        ref = Database.database().reference(withPath: "cars")
//        let carRef = self.ref.child(cars.id)
//        carRef.setValue("manufacturer": cars.manufacturer, "model": cars.model)
    }
    
    func createUser() {
//        guard let currentUser = Auth.auth().currentUser else { return }
//        user.uid = currentUser.uid
//        user.email = currentUser.email ?? ""
//        ref = Database.database().reference(withPath: "users").child(user.uid).child("car")
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        saveCar()
//    }
}
    
    




