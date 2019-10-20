//
//  SaveChangesSegue.swift
//  CarsList
//
//  Created by MacBook Air on 05/10/2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//
import UIKit

extension ListTableViewController {

    @IBAction func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UITableViewController) {
            
            guard unwindSegue.identifier == "SaveSegue" else { return }
            let source = unwindSegue.source as! AddEditTableViewController
            source.updateCar()
            var car = source.cars
            guard car.manufacturer != "" && car.model != "" && car.bodyType != "" && car.productionYear > 0 && car.price > 0 && (selectedImage != nil || car.urlPhoto != "") else {
                callAlert(withText: "Please fill in all fields and select a photo")
                return
            }
            if let selectedPath = tableView.indexPathForSelectedRow {
    //edited cell
                cars[selectedPath.row] = car
                if selectedImage != nil {
 
                    storageRef.child(car.id).delete { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                    car.ref?.removeValue()
                    
                    let newStorageRef = storageRef.child(car.id)
                    guard let imageData = selectedImage?.jpegData(compressionQuality: 0.5) else { return }
                    newStorageRef.putData(imageData, metadata: nil) { metadata, error in
                        guard metadata != nil else {
                            print(error?.localizedDescription as Any)
                            return
                        }
                        newStorageRef.downloadURL { url, error in
                            guard let downloadUrl = url else {
                                print(error?.localizedDescription as Any)
                                return
                            }
                            let urlPhoto = downloadUrl.absoluteString
                            car.ref?.updateChildValues(["id": car.id, "urlPhoto": urlPhoto, "manufacturer": car.manufacturer, "model": car.model, "productionYear": car.productionYear, "bodyType": car.bodyType, "price": car.price, "dateOfAdding": car.dateOfAdding])
                            selectedImage = nil
                        }
                    }
                } else {
                    car.ref?.updateChildValues(["id": car.id, "urlPhoto": car.urlPhoto, "manufacturer": car.manufacturer, "model": car.model, "productionYear": car.productionYear, "bodyType": car.bodyType, "price": car.price, "dateOfAdding": car.dateOfAdding])
                }
            } else {
    //added cell
                car.id = car.createUniqueId()
                let newRef = self.ref.child(car.id)
                let newStorageRef = storageRef.child(car.id)
                print(newStorageRef)
                guard let imageData = selectedImage?.jpegData(compressionQuality: 0.5) else { return }
                newStorageRef.putData(imageData, metadata: nil) { metadata, error in
                    guard metadata != nil else {
                        print(error?.localizedDescription as Any)
                        return
                    }
                    newStorageRef.downloadURL { url, error in
                        guard let downloadUrl = url else {
                            print(error?.localizedDescription as Any)
                            return
                        }
                        let urlPhoto = downloadUrl.absoluteString
                        print(urlPhoto)
                        newRef.setValue(["id": car.id, "urlPhoto": urlPhoto, "manufacturer": car.manufacturer, "model": car.model, "productionYear": car.productionYear, "bodyType": car.bodyType, "price": car.price, "dateOfAdding": car.dateOfAdding])
                        selectedImage = nil
                    }
                }
            }
        }
}
