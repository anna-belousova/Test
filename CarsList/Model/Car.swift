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

extension Car {
    static var all: [Car] {
        return [
            Car(id: "mgCIF6RNXBkfVuXt", manufacturer: "Toyota", model: "Camry", productionYear: 2010, bodyType: "Sedan", urlPhoto: "https://firebasestorage.googleapis.com/v0/b/carslist-663ea.appspot.com/o/images%2FmgCIF6RNXBkfVuXt.jpg?alt=media&token=5221a029-0bdf-4802-989f-94893feb7039" , price: 1000000),
            Car(id: "T71uz830PwiumSPT", manufacturer: "BMW", model: "X6", productionYear: 2008, bodyType: "Crossover", urlPhoto: "https://firebasestorage.googleapis.com/v0/b/carslist-663ea.appspot.com/o/images%2FT71uz830PwiumSPT.jpg?alt=media&token=840683d2-04b2-4d63-bb22-dcd1bcbc1462", price: 5000000)
        ]
    }
    static func loadDefaults() -> [Car] {
           return all
       }
}
