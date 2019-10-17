//
//  ListTableViewController.swift
//  CarsList
//
//  Created by MacBook Air on 02/10/2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class ListTableViewController: UITableViewController {
    
    var cars = [Car]()
    var carCell = CarCell()
    let ref = Database.database().reference(withPath: "cars")
    let storageRef = Storage.storage().reference().child("images")

    override func viewDidLoad() {
        super.viewDidLoad()
        getSnapshot()
    }
    
    func getSnapshot() {
        ref.queryOrdered(byChild: "id").observe(.value, with: { snapshot in
            var newCar: [Car] = []
            for child in snapshot.children {
                guard let snapshot = child as? DataSnapshot, let car = Car(snapshot: snapshot) else { return }
                    newCar.append(car)
            }
            self.cars = newCar
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as! CarCell
        let car = cars[indexPath.row]
        cell.descriptionLabel.text = "\(car.manufacturer) \(car.model), \(car.productionYear)"
        cell.priceLabel.text = "\(car.price) руб."
        cell.photoImageView.loadImagesUsingCache(urlString: car.urlPhoto)
        print("image loaded in list")
        return cell
    }
 
    // MARK: - Editing table view
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let car = cars[indexPath.row]
            let deleteRef = storageRef.child(car.id)
            deleteRef.delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            car.ref?.removeValue()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EditSegue" else { return }
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
        let car = cars[selectedPath.row]
        let destination = segue.destination as! AddEditTableViewController
        destination.cars = car
    }
    
    func callAlert(withText text: String) {
          let alert = UIAlertController(title: "\(text)", message: nil, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
              alert.dismiss(animated: true, completion: nil)
          }))
          performSegue(withIdentifier: "PresentSegue", sender: nil)
          present(alert, animated: true)
      }
          
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UITableViewController) {
        guard unwindSegue.identifier == "SaveSegue" else { return }
        let source = unwindSegue.source as! AddEditTableViewController
        source.updateCar()
        var car = source.cars
        guard selectedImage != nil else {
            callAlert(withText: "Choose the photo for your car")
            return
        }
        if let selectedPath = tableView.indexPathForSelectedRow {
//edited cell
            cars[selectedPath.row] = car
            car.ref?.updateChildValues(car.toAnyObject() as! [AnyHashable : Any])
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
                print(metadata)
                newStorageRef.downloadURL { url, error in
                    guard let downloadUrl = url else {
                        print(error?.localizedDescription as Any)
                        return
                    }
                    let urlPhoto = downloadUrl.absoluteString
                    print(urlPhoto)
                    newRef.setValue(["id": car.id, "urlPhoto": urlPhoto, "manufacturer": car.manufacturer, "model": car.model, "productionYear": car.productionYear, "bodyType": car.bodyType, "price": car.price])
                    selectedImage = nil
                }
            }
        }
    }
        

        
    
    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error.localizedDescription)
        }
        self.navigationController?.popViewController(animated: true)
        print("sign out")
    }
}
