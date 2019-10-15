//
//  Navigation Segues.swift
//  CarsList
//
//  Created by MacBook Air on 05/10/2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//
import UIKit

extension ListTableViewController {
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//           guard segue.identifier == "EditSegue" else { return }
//           guard let selectedPath = tableView.indexPathForSelectedRow else { return }
//           let car = cars[selectedPath.row]
//           let destination = segue.destination as! AddEditTableViewController
//           destination.cars = car
//       }
//       
//       @IBAction func unwind(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UITableViewController) {
//           guard unwindSegue.identifier == "SaveSegue" else { return }
//           let source = unwindSegue.source as! AddEditTableViewController
//           let car = source.cars
//           if let selectedPath = tableView.indexPathForSelectedRow {
//               //edited cell
//               cars[selectedPath.row] = car
//               tableView.reloadRows(at: [selectedPath], with: .automatic)
//           } else {
//               //added cell
//               let indexPath = IndexPath(row: cars.count, section: 0)
//               cars.append(car)
//               tableView.insertRows(at: [indexPath], with: .automatic)
//           }
//       }
}
