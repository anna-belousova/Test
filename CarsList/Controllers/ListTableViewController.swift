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
        cell.priceLabel.text = "\(car.price) $"
        cell.photoImageView.loadImagesUsingCache(urlString: car.urlPhoto)
        cell.configure(cell: carCell)
        return cell
    }
 
    // MARK: - Editing table view
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let car = cars[indexPath.row]
            storageRef.child(car.id).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            car.ref?.removeValue()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if view.bounds.size.height > view.bounds.size.width {
            let aspectRatio: CGFloat = 120/896
            return aspectRatio * view.bounds.size.height
        } else {
            let aspectRatio: CGFloat = 100/414
            return aspectRatio * view.bounds.size.height
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
        selectedImage = nil
          }
    
    
    @IBAction func signOutTapped(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error.localizedDescription)
        }
        self.dismiss(animated: true, completion: nil)
        //navigationController?.popViewController(animated: true)
        print("sign out")
    }
}

