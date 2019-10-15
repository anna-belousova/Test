//
//  CarCell.swift
//  CarsList
//
//  Created by MacBook Air on 02/10/2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    func configure(_ cell: CarCell, cars: Car) {
//        do {
//        try cell.photo.image = UIImage(data: Data(contentsOf: URL(string: cars.photo)!))
//        } catch {
//            print(error.localizedDescription)
//        }
        cell.descriptionLabel.text = "\(cars.manufacturer) \(cars.model), \(cars.productionYear)"
        cell.priceLabel.text = "\(cars.price) руб."
    }
}
