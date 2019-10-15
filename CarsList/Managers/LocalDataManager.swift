//
//  LocalDataManager.swift
//  CarsList
//
//  Created by MacBook Air on 09/10/2019.
//  Copyright © 2019 MacBook Air. All rights reserved.
//

import Foundation

class LocalDataManager {
//
//    var archiveURL: URL? {
//        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            return nil
//        }
//        return documentDirectory.appendingPathComponent("cars").appendingPathExtension("plist")
//    }
//
//    func loadCars() -> [Car]? {
//        guard let archiveURL = archiveURL else { return nil }
//        guard let encodedCars = try? Data(contentsOf: archiveURL) else { return nil }
//
//        let decoder = PropertyListDecoder()
//        return try? decoder.decode([Car].self, from: encodedCars)
//    }
//
//    func saveCars(_ cars: [Car]) {
//        let encoder = PropertyListEncoder()
//        guard let encodedCars = try? encoder.encode(cars) else { return }
//        guard let archiveURL = archiveURL else { return }
//        try? encodedCars.write(to: archiveURL, options: .noFileProtection)
//    }
}
