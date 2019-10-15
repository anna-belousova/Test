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
    var photo: String
    var price: Int
    var ref: DatabaseReference?
    
    init(id: String = "", manufacturer: String = "", model: String = "", productionYear: Int = 0, bodyType: String = "", photo: String = "", price: Int = 0) {
        self.ref = nil
        self.id = id
        self.manufacturer = manufacturer
        self.model = model
        self.productionYear = productionYear
        self.bodyType = bodyType
        self.photo = photo
        self.price = price
    }
        
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: AnyObject],
        let id = value["id"] as? String,
        let manufacturer = value["manufacturer"] as? String,
        let model = value["model"] as? String,
        let productionYear = value["productionYear"] as? Int,
        let bodyType = value["bodyType"] as? String,
        let price = value["price"] as? Int,
        let photo = value["photo"] as? String
        else { return nil }
        
        self.ref = snapshot.ref
        self.id = id
        self.manufacturer = manufacturer
        self.model = model
        self.productionYear = productionYear
        self.bodyType = bodyType
        self.photo = photo
        self.price = price
    }
        
    func toAnyObject() -> Any {
        return [
            "id": id, "photo": photo, "manufacturer": manufacturer, "model": model, "productionYear": productionYear, "bodyType": bodyType, "price": price
        ]
    }
    
    func createUniqueId() -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<16).map{ _ in letters.randomElement()! })
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
}

extension Car {
    static var all: [Car] {
        return [
            Car(
                id: "1",
                manufacturer: "Toyota", model: "Camry", productionYear: 2019, bodyType: "Sedan",
                photo: "" , price: 1593000),
            Car(
                id: "2",
                manufacturer: "BMW", model: "X6", productionYear: 2018, bodyType: "Crossover",
                photo: "", price: 5420000),
            Car(
                id: "3",
                manufacturer: "Audi", model: "Q8", productionYear: 2019, bodyType: "Crossover",
                photo: "", price: 5040000)
        ]
    }
//    static func loadDefaults() -> [Car] {
//           return all
//       }
}
