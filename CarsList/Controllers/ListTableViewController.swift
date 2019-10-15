//
//  ListTableViewController.swift
//  CarsList
//
//  Created by MacBook Air on 02/10/2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import UIKit
import Firebase

class ListTableViewController: UITableViewController {
    
    var cars = [Car]()
    var carCell = CarCell()
    var ref = Database.database().reference(withPath: "cars")
    var selectedCar: Car? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.queryOrdered(byChild: "id").observe(.value, with: { snapshot in
            var newCar: [Car] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot, let car = Car(snapshot: snapshot) {
                    newCar.append(car)

                }
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
        let car = cars[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell") as! CarCell
        carCell.configure(cell, cars: car)
        return cell
    }

    // MARK: - Editing table view
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let car = cars[indexPath.row]
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
          
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UITableViewController) {
        guard unwindSegue.identifier == "SaveSegue" else { return }
        let source = unwindSegue.source as! AddEditTableViewController
        source.updateCar()
        let car = source.cars
        if let selectedPath = tableView.indexPathForSelectedRow {
            //edited cell
            cars[selectedPath.row] = car
            car.ref?.updateChildValues(car.toAnyObject() as! [AnyHashable : Any])
//            car.ref?.updateChildValues(["id": car.id, "photo": car.photo, "manufacturer": car.manufacturer, "model": car.model, "productionYear": car.productionYear, "bodyType": car.bodyType, "price": car.price])
            } else {
                  //added cell
            let newRef = self.ref.child(car.id)
            newRef.setValue(car.toAnyObject())
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
