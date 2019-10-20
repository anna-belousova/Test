//
//  Cars.swift
//  CarsList
//
//  Created by MacBook Air on 02/10/2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import Firebase

struct Car {
    var id: String
    var manufacturer: String
    var model: String
    var productionYear: Int
    var bodyType: String
    var urlPhoto: String
    var price: Int
    var dateOfAdding: String
    var ref: DatabaseReference?
    
    init(id: String = "", manufacturer: String = "", model: String = "", productionYear: Int = 0, bodyType: String = "", urlPhoto: String = "", price: Int = 0, dateOfAdding: String = "") {
        self.ref = nil
        self.id = id
        self.manufacturer = manufacturer
        self.model = model
        self.productionYear = productionYear
        self.bodyType = bodyType
        self.urlPhoto = urlPhoto
        self.price = price
        self.dateOfAdding = dateOfAdding
    }
        
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: AnyObject],
        let id = value["id"] as? String,
        let manufacturer = value["manufacturer"] as? String,
        let model = value["model"] as? String,
        let productionYear = value["productionYear"] as? Int,
        let bodyType = value["bodyType"] as? String,
        let price = value["price"] as? Int,
        let urlPhoto = value["urlPhoto"] as? String,
        let dateOfAdding = value["dateOfAdding"] as? String
        else { return nil }
        
        self.ref = snapshot.ref
        self.id = id
        self.manufacturer = manufacturer
        self.model = model
        self.productionYear = productionYear
        self.bodyType = bodyType
        self.urlPhoto = urlPhoto
        self.price = price
        self.dateOfAdding = dateOfAdding
    }
    
    func createProductionYearArray() -> [Int] {
        var array: Array<Int> = []
        for i in 1990...2019 {
            array.append(i)
        }
        array.reverse()
        return array
    }
    
    func createBodyTypeArray() -> [String] {
        return ["Sedan", "Hatchback", "MPV", "SUV", "Crossover", "Coupe", "Convertible"]
    }
    
    func createUniqueId() -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<16).map{ _ in letters.randomElement()! })
    }
}

